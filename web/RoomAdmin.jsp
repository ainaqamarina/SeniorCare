<jsp:include page="SidebarAdmin.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Rooms</title>
 
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Roboto', sans-serif;
        }

        /* Animated Gradient Background */
        body {
            animation: gradient 15s ease infinite;
            background: linear-gradient(to right, #e3f2fd, #42a5f5);
            background-size: 400% 400%;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* Glassmorphism Effect */
        .container {
            background: rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(12px);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
            transform: translateX(13%); 
        }

        h1 {
            font-size: 24px;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        label {
            font-size: 14px;
            color: #555;
            width: 130px;
            margin-right: 15px;
            text-align: left;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"] {
            flex: 1;
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s;
            height: 40px;
            background: rgba(255, 255, 255, 0.5);
        }

        input[type="file"] {
            cursor: pointer;
        }

        input:focus {
            border-color: #2980b9;
        }

        input.filled {
            border-color: #28a745;
        }

        .btn-submit {
            background: #2980b9;
            color: white;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 15px;
        }

        .btn-submit:hover {
            background: #3498db;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Manage Room Packages</h1>
        
        <form action="RoomServlet" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="room_id">Room ID:</label>
                <input type="text" id="room_id" name="room_id" required pattern="[A-Za-z0-9]{1,10}" 
                    title="Max 10 alphanumeric characters" oninput="checkInput(this)">
            </div>

            <div class="form-group">
                <label for="room_package">Package Name:</label>
                <input type="text" id="room_package" name="room_package" required oninput="checkInput(this)">
            </div>

            <div class="form-group">
                <label for="room_price">Price (RM):</label>
                <input type="number" id="room_price" name="room_price" required min="0" oninput="checkInput(this)">
            </div>
            
            

            <div class="form-group">
                <label for="room_picture">Picture:</label>
                <input type="file" id="room_picture" name="room_picture" accept="image/*" required oninput="checkInput(this)">
            </div>

            <button type="submit" class="btn-submit">Add Room Package</button>
        </form>
    </div>

    <script>
        function checkInput(input) {
            if (input.value) {
                input.classList.add('filled');
            } else {
                input.classList.remove('filled');
            }
        }
    </script>
    
</body>
</html>