package controller;

import java.io.File;
import java.io.FileOutputStream;
import bean.TherapyBean;
import dao.TherapyDao;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/TherapyServlet")
@MultipartConfig // Required for handling file uploads
public class TherapyServlet extends HttpServlet {

    // Handle Adding & Updating Therapy (POST Request)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("update".equals(action)) {
                updateTherapy(request, response); // Call update method
            } else {
                addTherapy(request, response); // Call add method
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminTherapyList.jsp?error=true");
        }
    }

    // Handle Adding Therapy
    private void addTherapy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String therapy_id = request.getParameter("therapy_id"); // Keep as String
            String therapy_package = request.getParameter("therapy_package");
            double therapy_price = Double.parseDouble(request.getParameter("therapy_price"));

            // Handle File Upload
            Part filePart = request.getPart("therapy_picture");
            if (filePart == null || filePart.getSize() == 0) {
                throw new Exception("File upload failed!");
            }

            // Set the directory where you want to save the uploaded file
            String uploadsDir = getServletContext().getRealPath("/uploads");
            File uploadsDirFile = new File(uploadsDir);

            // Create the uploads directory if it doesn't exist
            if (!uploadsDirFile.exists()) {
                uploadsDirFile.mkdir();
            }

            // Get the filename
            String fileName = filePart.getSubmittedFileName();
            File file = new File(uploadsDirFile, fileName);

            // Save the file to the server
            try (InputStream fileContent = filePart.getInputStream();
                    FileOutputStream fos = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            // Create Therapy Object
            TherapyBean therapy = new TherapyBean();
            therapy.setTherapyId(therapy_id);
            therapy.setTherapyPackage(therapy_package);
            therapy.setTherapyPrice(therapy_price);
            therapy.setTherapyPicture(fileName); // Store filename in the TherapyBean

            // Insert Therapy into DB
            boolean isSuccess = TherapyDao.addTherapy(therapy);

            if (isSuccess) {
                response.sendRedirect("AdminTherapyList.jsp?message=Therapy Added Successfully");
            } else {
                response.sendRedirect("AdminTherapyList.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace(); // ✅ Log errors
            response.sendRedirect("AdminTherapyList.jsp?error=true");
        }
    }

    // Handle Updating Therapy
    private void updateTherapy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String therapyId = request.getParameter("therapy_id");
            String therapyPackage = request.getParameter("therapy_package");
            double therapyPrice = Double.parseDouble(request.getParameter("therapy_price"));

            // Handle File Upload (optional)
            Part filePart = request.getPart("therapy_picture");
            String fileName = null;
            
            if (filePart != null && filePart.getSize() > 0) {
                fileName = filePart.getSubmittedFileName();

                // Set the directory where you want to save the uploaded file
                String uploadsDir = getServletContext().getRealPath("/uploads");
                File uploadsDirFile = new File(uploadsDir);

                // Create the uploads directory if it doesn't exist
                if (!uploadsDirFile.exists()) {
                    uploadsDirFile.mkdir();
                }

                // Save the file to the server
                File file = new File(uploadsDirFile, fileName);
                try (InputStream fileContent = filePart.getInputStream();
                        FileOutputStream fos = new FileOutputStream(file)) {
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = fileContent.read(buffer)) != -1) {
                        fos.write(buffer, 0, bytesRead);
                    }
                }
            }

            // Update Therapy in the database
            boolean isSuccess = TherapyDao.updateTherapy(therapyId, therapyPackage, therapyPrice, fileName);

            if (isSuccess) {
                response.sendRedirect("AdminTherapyList.jsp?message=Therapy Updated Successfully");
            } else {
                response.sendRedirect("AdminTherapyList.jsp?error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminTherapyList.jsp?error=true");
        }
    }

    // Handle Deleting Therapy (GET Request)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String therapyId = request.getParameter("therapy_id");

        if ("delete".equals(action)) {
            boolean deleted = TherapyDao.deleteTherapy(therapyId);
            if (deleted) {
                response.sendRedirect("AdminTherapyList.jsp?message=Therapy Deleted Successfully");
            } else {
                response.sendRedirect("AdminTherapyList.jsp?error=Error deleting therapy");
            }
        }
    }
}
