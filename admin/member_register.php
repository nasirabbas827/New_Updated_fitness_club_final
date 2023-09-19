<?php
session_start();
include('config.php');

// Check if the user is logged in as an admin
if (!isset($_SESSION["usertype"]) || $_SESSION["usertype"] !== "admin") {
    header("Location: admin_login.php");
    exit;
}

$error = ""; // Initialize an error message variable

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $profileImage = $_FILES['profile_image']['name'];
    $tempImage = $_FILES['profile_image']['tmp_name'];
    $name = $_POST['name'];
    $gender = $_POST['gender'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $phone = $_POST['phone'];
    $address = $_POST['address'];
    $membershipStartDate = $_POST['membership_start_date'];
    $membershipLevel = $_POST['membership_level']; // The level ID

    // Check if username already exists
    $sqlUsernameCheck = "SELECT * FROM members WHERE name = '$name'";
    $resultUsernameCheck = $conn->query($sqlUsernameCheck);

    // Check if email already exists
    $sqlEmailCheck = "SELECT * FROM members WHERE email = '$email'";
    $resultEmailCheck = $conn->query($sqlEmailCheck);

    // Check if phone number already exists
    $sqlPhoneCheck = "SELECT * FROM members WHERE phone = '$phone'";
    $resultPhoneCheck = $conn->query($sqlPhoneCheck);

    // Check if username or email or phone already exists
    if ($resultUsernameCheck->num_rows > 0) {
        $error = "Name already exists.";
    } elseif ($resultEmailCheck->num_rows > 0) {
        $error = "Email already exists.";
    } elseif ($resultPhoneCheck->num_rows > 0) {
        $error = "Phone number already exists.";
    } else {
        // Fetch the membership level duration from the database and convert it to days
        $sqlLevelDuration = "SELECT duration FROM membership_levels WHERE LevelID = $membershipLevel";
        $resultLevelDuration = $conn->query($sqlLevelDuration);

        if ($resultLevelDuration->num_rows === 0) {
            // Handle the case where the level ID is not found
            $error = "Invalid membership level selected.";
        } else {
            $levelData = $resultLevelDuration->fetch_assoc();
            $membershipDurationInMonths = $levelData['duration'];

            // Convert the membership duration from months to days
            $membershipDurationInDays = $membershipDurationInMonths * 30; // Assuming 30 days in a month

            // Calculate the membership expiry date by adding days to the start date
            $membershipExpiryDate = date('Y-m-d', strtotime($membershipStartDate . " + $membershipDurationInDays days"));

            // Upload the profile image to a directory (you may need to create the 'uploads' directory)
            $uploadDirectory = 'uploads/';
            $profileImageName = $_FILES['profile_image']['name']; // Get the image name
            $profileImagePath = $uploadDirectory . $profileImageName;
            move_uploaded_file($_FILES['profile_image']['tmp_name'], $profileImagePath);

            // Set status to "verified" and verification_token to NULL for admin-added members
            $status = 'verified';
            $verificationToken = null;

            // SQL query to insert member data into the database
            $sql = "INSERT INTO members (profileimage, name, gender, email, password, phone, address, membership_start_date, membership_expiry_date, membership_level, verification_token, status)
                    VALUES ('$profileImageName', '$name', '$gender', '$email', '$password', '$phone', '$address', '$membershipStartDate', '$membershipExpiryDate', $membershipLevel, '$verificationToken', '$status')";

            if ($conn->query($sql) === TRUE) {
                // Redirect to the fee payment page with the membership level information in the URL
                header("Location: fee_submission.php?level_id=$membershipLevel&member_id=" . $conn->insert_id);
                exit;
            } else {
                $error = "Error: " . $sql . "<br>" . $conn->error;
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Member</title>
    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/style.css">
</head>
<body>
<?php
include('admin_navbar.php');
?>
<?php if (!empty($error)) { echo "<p style='color: red;'>$error</p>"; } ?>
<div class="container mt-5">
    <h2>Add Member</h2>

    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="profile_image">Profile Image:</label>
                <input type="file" class="form-control" id="profile_image" name="profile_image" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="name">Name:</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="col-md-6 mb-3">
                <label>Gender:</label>
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="male" name="gender" value="Male" required>
                    <label class="form-check-label" for="male">Male</label>
                </div>
                <div class="form-check">
                    <input type="radio" class="form-check-input" id="female" name="gender" value="Female" required>
                    <label class="form-check-label" for="female">Female</label>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="col-md-6 mb-3">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="phone">Phone Number:</label>
                <input type="text" class="form-control" id="phone" name="phone" required>
            </div>

            <div class="col-md-6 mb-3">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" required>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="membership_start_date">Membership Start Date:</label>
                <input type="date" class="form-control" id="membership_start_date" name="membership_start_date" required>
            </div>

            <div class="col-md-6 mb-3">
                <label for="membership_level">Membership Level:</label>
                <select class="form-control" id="membership_level" name="membership_level" required>
                    <?php
                    // Fetch membership levels from the database and populate the dropdown options
                    $sql = "SELECT * FROM membership_levels";
                    $result = $conn->query($sql);
                    while ($row = $result->fetch_assoc()) {
                        echo "<option value='" . $row['LevelID'] . "'>" . $row['level_name'] . "</option>";
                    }
                    ?>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <button type="submit" class="btn btn-primary">Add Member</button>
            </div>
        </div>
    </form>
</div>

<!-- Include Bootstrap JS and Popper.js (for Bootstrap functionality) -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>



