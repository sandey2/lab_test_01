<?php
class DBConnection
{
    private $hostname = 'localhost';
    private $username = 'root';
    private $userpass = '';
    private $database = 'ngam_sandey';

    public function connect()
    {
        try {
            $conn = mysqli_connect(
                $this->hostname,
                $this->username,
                $this->userpass,
                $this->database
            );

            // Check connection
            if (!$conn) {
                throw new Exception("Connection failed: " . mysqli_connect_error());
            }

            return $conn;
        } catch (Exception $ex) {
            echo "Error: " . $ex->getMessage();
        }
    }
}
