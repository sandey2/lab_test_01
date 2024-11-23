<?php
class functions {
    // Data members or member variables
    private $db;
    private $sql;
    private $result;

    // Constructor
    public function __construct() {
        require_once 'Db_Connection.php';
        // create an instance of class DbConnection
        $this->db = new DBConnection();
        // calling the method : Connection os clase DBConnection
        $this->db->connect();
    }

    // Destructor
    public function __destruct() {
        //close ther connection
        $this->db->connect()->close();
    }

    // Methods
    public function insert_data($tablename, $fields, $values) {
        // Count fields in array
        $count = count($fields);
        // Generate insert statement
        $this->sql = "INSERT INTO $tablename (";
        
        // Append fields to SQL
        for($i = 0; $i < $count; $i++){
            $this->sql .= $fields[$i];
            if ($i < $count - 1) {
                $this->sql .= ", "; // Add comma between fields
            }else{
                $this->sql .= ") VALUES(";
            }
        }
        for($i = 0; $i < $count; $i++){
            $this->sql .="'" .$values[$i]."'";
            if($i<$count -1){
                $this->sql .= ", "; 
            }else{
                    $this->sql .= ");";
            }
        }
        // return $this->sql;
        $this->result = $this->db->connect()->query($this->sql);
        if($this->result ===TRUE) {
            return true;
        }else{
            return false;
        }
    }
}
?>
