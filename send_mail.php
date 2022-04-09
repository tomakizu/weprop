<?
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require 'lib/PHPMailer/src/Exception.php';
require 'lib/PHPMailer/src/PHPMailer.php';
require 'lib/PHPMailer/src/SMTP.php';

$mail = new PHPMailer();
$mail->isSMTP();
$mail->CharSet = 'UTF-8';
$mail->Encoding = 'base64';
$mail->SMTPAuth = true;
$mail->SMTPSecure = 'ssl';
$mail->Host = 'smtp.gmail.com';
$mail->Port = '465';
$mail->isHTML();
$mail->Username = 'fyp.202107@gmail.com';
$mail->Password = 'daisiirsdo';
$mail->SetFrom('no-reply@weprop.com.hk', 'WeProp');
$mail->Subject = 'Albert is simp';
$mail->Body = 'Hello World!';
$mail->AddAddress('190056972@stu.vtc.edu.hk');

echo json_encode($mail->Send());
?>
