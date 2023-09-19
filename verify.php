<?php
include('config.php');

if (isset($_GET['token'])) {
    $token = $_GET['token'];

    // Check if the token exists in the database
    $sql = "SELECT * FROM members WHERE verification_token = '$token'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Token found, mark the user as 'verified'
        $row = $result->fetch_assoc();
        $userId = $row['MemberID'];
        $updateSql = "UPDATE members SET status = 'verified' WHERE MemberID = $userId";
        if ($conn->query($updateSql) === TRUE) {
            echo "Email verification successful. You can now log in.";
        } else {
            echo "Error updating user status: " . $conn->error;
        }
    } else {
        echo "Invalid or expired verification token.";
    }
} else {
    echo "Token not provided.";
}
?>
