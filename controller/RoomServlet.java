package controller;

import java.io.File;
import java.io.FileOutputStream;
import bean.RoomBean;
import dao.RoomDao;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/RoomServlet")
@MultipartConfig // Required for handling file uploads
public class RoomServlet extends HttpServlet {

    // Handle Adding & Updating Room (POST Request)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");

            if ("update".equals(action)) {
                updateRoom(request, response); // Call update method
            } else {
                addRoom(request, response); // Call add method
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminRoomList.jsp?error=true");
        }
    }

// Handle Adding Room
    private void addRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String room_id = request.getParameter("room_id"); // Keep as String
            String room_package = request.getParameter("room_package");
            double room_price = Double.parseDouble(request.getParameter("room_price"));

            // Handle File Upload
            Part filePart = request.getPart("room_picture");
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

            // Create Room Object
            RoomBean room = new RoomBean();
            room.setRoomId(room_id);
            room.setRoomPackage(room_package);
            room.setRoomPrice(room_price);
            room.setRoomPicture(fileName); // Store filename in the RoomBean

            // Insert Room into DB
            boolean isSuccess = RoomDao.addRoom(room);

            if (isSuccess) {
                response.sendRedirect("AdminRoomList.jsp?message=Room Added Successfully");
            } else {
                response.sendRedirect("AdminRoomList.jsp?error=true");
            }
        } catch (Exception e) {
            e.printStackTrace(); // ✅ Log errors
            response.sendRedirect("AdminRoomList.jsp?error=true");
        }
    }

    // Handle Updating Room
    private void updateRoom(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String roomId = request.getParameter("room_id");
            String roomPackage = request.getParameter("room_package");
            double roomPrice = Double.parseDouble(request.getParameter("room_price"));

            // Handle File Upload (optional)
            Part filePart = request.getPart("room_picture");
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

            // Update Room in the database
            boolean isSuccess = RoomDao.updateRoom(roomId, roomPackage, roomPrice, fileName);

            if (isSuccess) {
                response.sendRedirect("AdminRoomList.jsp?message=Room Updated Successfully");
            } else {
                response.sendRedirect("AdminRoomList.jsp?error=Update Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("AdminRoomList.jsp?error=true");
        }
    }

    // Handle Deleting Room (GET Request)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String roomId = request.getParameter("room_id");

        if ("delete".equals(action)) {
            boolean deleted = RoomDao.deleteRoom(roomId);
            if (deleted) {
                response.sendRedirect("AdminRoomList.jsp?message=Room Deleted Successfully");
            } else {
                response.sendRedirect("AdminRoomList.jsp?error=Error deleting room");
            }
        }
    }
}
