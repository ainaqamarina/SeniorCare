<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <h2>Dashboard</h2>
        <a href="#"><i class="fas fa-home"></i> Home</a>
        <a href="UserProfile.html"><i class="fas fa-user"></i> Profile</a>
        <a href="index.html" onclick="logout()"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <h1>Welcome to your Dashboard</h1>
        <div class="section">
            <!-- Room Package Card -->
            <div class="card">
                <h3>Room Package</h3>
                <p>Choose your package for stay here</p>
                <a href="UserRoomPackage.jsp" class="btn">View Room</a>
            </div>

            <!-- Therapy Card -->
            <div class="card">
                <h3>Therapy Package</h3>
                <p>Track your therapy sessions and progress.</p>
                <a href="UserTherapy.jsp" class="btn">View Therapy</a>
            </div>

            <!-- Room History Card -->
            <div class="card">
                <h3>Room History</h3>
                <p>Lets view your room history</p>
                <a href="UserRoomHistory.jsp" class="btn">View History</a>
            </div>

            <!-- Therapy History Card -->
            <div class="card">
                <h3>Therapy History</h3>
                <p>Lets view your therapy history</p>
                <a href="UserTherapyHistory.jsp" class="btn">View History</a>
            </div>
        </div>

        <!-- Footer -->
        <footer>
            &copy; 2024 Senior Care Coordinate System. All rights reserved.
        </footer>
    </div>
    
    <script>
        function logout() {
            alert("You have been logged out.");
            window.location.href = "login.html"; 
        }
    </script>
</body>
</html>