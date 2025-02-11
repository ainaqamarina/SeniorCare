<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Room Package History</title>
    <link rel="stylesheet" href="css/hist.css">
    <style>
        .search-container {
            margin-bottom: 20px;
            text-align: center;
        }

        .search-input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 100%; 
            box-sizing: border-box; 
        }
    </style>
</head>
<body>
    
    <div class="history-container">
        <h1>Room Booking History</h1>
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="Search by Room Name">
        </div>
        <div class="history-list">
            <div class="history-item">
                <div class="history-title">Single Room</div>
                <div class="history-details">
                    <div class="history-record"><strong>Check In Date:</strong> 2024-01-26</div>
                    <div class="history-record"><strong>Check Out Date:</strong> 2024-01-28</div>
                    <div class="history-record"><strong>Booking Duration:</strong> 3 days</div>
                    <div class="history-record"><strong>Total:</strong> Rm 150</div>
                </div>
            </div>

            <div class="history-item">
                <div class="history-title">Double Room</div>
                <div class="history-details">
                    <div class="history-record"><strong>Check In Date:</strong> 2024-01-26</div>
                    <div class="history-record"><strong>Check Out Date:</strong> 2024-01-28</div>
                    <div class="history-record"><strong>Booking Duration:</strong> 2 days</div>
                    <div class="history-record"><strong>Total:</strong> Rm 200</div>
                </div>
            </div>

            <div class="history-item">
                <div class="history-title">Triple Room</div>
                <div class="history-details">
                    <div class="history-record"><strong>Check In Date:</strong> 2024-01-26</div>
                    <div class="history-record"><strong>Check Out Date:</strong> 2024-02-04</div>
                    <div class="history-record"><strong>Booking Duration:</strong> 7 days</div>
                    <div class="history-record"><strong>Total:</strong> Rm 5000</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>