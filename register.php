<?php
session_start();
include('config.php');
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require './PHPMailer/src/Exception.php';
require './PHPMailer/src/PHPMailer.php';
require './PHPMailer/src/SMTP.php';

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

    if ($resultUsernameCheck->num_rows > 0) {
        $error = "Username already exists. Please choose a different username.";
    } elseif ($resultEmailCheck->num_rows > 0) {
        $error = "Email address already exists. Please use a different email address.";
    } elseif ($resultPhoneCheck->num_rows > 0) {
        $error = "Phone number already exists. Please use a different phone number.";
    } else {
        // Fetch the membership level duration from the database and convert it to days
        $sqlLevelDuration = "SELECT duration FROM membership_levels WHERE LevelID = $membershipLevel";
        $resultLevelDuration = $conn->query($sqlLevelDuration);

        if ($resultLevelDuration->num_rows === 0) {
            // Handle the case where the level ID is not found
            // You can display an error message or take appropriate action
            $error = "Invalid membership level selected.";
        } else {
            $levelData = $resultLevelDuration->fetch_assoc();
            $membershipDurationInMonths = $levelData['duration'];

            // Convert the membership duration from months to days
            $membershipDurationInDays = $membershipDurationInMonths * 30; // Assuming 30 days in a month

            // Calculate the membership expiry date by adding days to the start date
            $membershipExpiryDate = date('Y-m-d', strtotime($membershipStartDate . " + $membershipDurationInDays days"));
        

        // Generate a unique verification token
        $verificationToken = uniqid();

        // Upload the profile image to a directory (you may need to create the 'uploads' directory)
        $uploadDirectory = './admin/uploads/';
        $profileImageName = $_FILES['profile_image']['name']; // Get the image name
        $profileImagePath = $uploadDirectory . $profileImageName;
        move_uploaded_file($_FILES['profile_image']['tmp_name'], $profileImagePath);


        // SQL query to insert member data into the database
        $sql = "INSERT INTO members (profileimage, name, gender, email, password, phone, address, membership_start_date, membership_expiry_date, membership_level, verification_token, status)
                VALUES ('$profileImageName', '$name', '$gender', '$email', '$password', '$phone', '$address', '$membershipStartDate', '$membershipExpiryDate', $membershipLevel, '$verificationToken', 'unverified')";

        if ($conn->query($sql) === TRUE) {
            // Create a new instance of PHPMailer
            $mail = new PHPMailer(true);

            // SMTP configuration
            $mail->isSMTP();
            $mail->Host = 'smtp.gmail.com'; // Replace with your SMTP host
            $mail->SMTPAuth = true;
            $mail->Username = 'nasiryt.827@gmail.com'; // Replace with your SMTP username
            $mail->Password = 'zmcrrapmywubsmhk'; // Replace with your SMTP password
            $mail->Port = 587; // Replace with your SMTP port (usually 587)

            // Send the email
            $mail->setFrom('nasiryt.827@gmail.com', 'NASIR ABBAS'); // Replace with your email and name
            $mail->addAddress($email, $username); // Recipient email and name
            $mail->Subject = "Confirmation Email";
            $mail->isHTML(true);
            $mail->Body = "Thank you for registering with us. Please click the following link to verify your email address: <a href='http://localhost/mem/verify.php?token=$verificationToken'>Verify Email</a>";

            if ($mail->send()) {
                // Redirect to the fee payment page with the membership level information in the URL
                header("Location: fee_submission.php?level_id=$membershipLevel&member_id=" . $conn->insert_id);
                exit;
            } else {
                echo "Email could not be sent. Mailer Error: " . $mail->ErrorInfo;
            }
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
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
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>
<?php
include('navbar.php');
?>
<div class="container mb-5">
    <h2 class="mt-4">Member Registration</h2>

    <?php
    if (isset($error)) {
        echo "<p style='color: red;'>$error</p>";
    }
    ?>

    <form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" method="post" enctype="multipart/form-data">
        <div class="row">
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="profile_image" class="form-label">Profile Image:</label>
                    <input type="file" class="form-control" id="profile_image" name="profile_image" required>
                </div>
                <div class="mb-3">
                    <label for="name" class="form-label">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="mb-3">
                    <label for="gender" class="form-label">Gender:</label>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="male" name="gender" value="Male" required>
                        <label class="form-check-label" for="male">Male</label>
                    </div>
                    <div class="form-check">
                        <input type="radio" class="form-check-input" id="female" name="gender" value="Female" required>
                        <label class="form-check-label" for="female">Female</label>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
            </div>
            <div class="col-md-6">
                <div class="mb-3">
                    <label for="password" class="form-label">Password:</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone Number:</label>
                    <input type="text" class="form-control" id="phone" name="phone" required>
                </div>
                <div class="mb-3">
                    <label for="address" class="form-label">Address:</label>
                    <input type="text" class="form-control" id="address" name="address" required>
                </div>
                <div class="mb-3">
                    <label for="membership_start_date" class="form-label">Membership Start Date:</label>
                    <input type="date" class="form-control" id="membership_start_date" name="membership_start_date" required>
                </div>
                <div class="mb-3">
                    <label for="membership_level" class="form-label">Membership Level:</label>
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
        </div>

        <div class="mb-3">
            <input type="submit" class="btn btn-primary" value="Add Member">
        </div>
    </form>
</div>

<!-- Include Bootstrap JavaScript (optional) -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
