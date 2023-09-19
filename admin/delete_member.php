<?php
session_start();
include('config.php');

// Check if the user is logged in as an admin
if (!isset($_SESSION["usertype"]) || $_SESSION["usertype"] !== "admin") {
    header("Location: admin_login.php");
    exit;
}

if ($_SERVER["REQUEST_METHOD"] == "GET" && isset($_GET["member_id"])) {
    $memberID = $_GET["member_id"];
    
    // Start a database transaction
    $conn->begin_transaction();

    try {
        // Delete fee data for the member
        $deleteFeeSql = "DELETE FROM payments WHERE MemberID = $memberID";
        if ($conn->query($deleteFeeSql) === TRUE) {
            // Delete member data
            $deleteMemberSql = "DELETE FROM members WHERE MemberID = $memberID";
            if ($conn->query($deleteMemberSql) === TRUE) {
                // Commit the transaction if both deletions are successful
                $conn->commit();
                echo "Member and fee data deleted successfully!";
            } else {
                throw new Exception("Error deleting member data: " . $conn->error);
            }
        } else {
            throw new Exception("Error deleting fee data: " . $conn->error);
        }
    } catch (Exception $e) {
        // Roll back the transaction in case of any errors
        $conn->rollback();
        echo "Error: " . $e->getMessage();
    }
}

$conn->close();
?>
