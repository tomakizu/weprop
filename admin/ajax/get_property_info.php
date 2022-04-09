<?
require('../../common/conn.php');

session_start();
if (!isSet($_SESSION['user'])) {
    echo "";
} else if ($_SESSION['user']['type'] != 'staff') {
    echo "";
} else {
    $property = array();
    if (isSet($_GET['building_id']) && isSet($_GET['floor'])) {
        $sql = $conn->prepare('SELECT * FROM property WHERE building_id=? AND floor=?');
        $sql->bind_param('ss', $_GET['building_id'], $_GET['floor']);
        $sql->execute();
        $result = $sql->get_result();
        while ($record = $result -> fetch_assoc()) {
            $property[] = $record;
        }
        echo json_encode($property);
    } else if (isSet($_GET['building_id'])) {
        $sql = $conn->prepare('SELECT * FROM property WHERE building_id=? ORDER BY floor ASC');
        $sql->bind_param('s', $_GET['building_id']);
        $sql->execute();
        $result = $sql->get_result();
        $temp = '';
        while ($record = $result -> fetch_assoc()) {
            if ($record['floor'] == $temp) continue;
            $property[] = $record;
            $temp = $record['floor'];
        }
        echo json_encode($property);
    }
}
?>
