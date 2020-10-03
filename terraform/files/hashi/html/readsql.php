<?php

/**
 * Function to query information based on
 * a parameter: in this case, location.
 *
 */

require "config.php";
try  {
    $connection = new PDO($dsn, $username, $password, $options);

    $sql = "SELECT FLOOR(RAND()*(100-0+1)) as 'random'";

    $statement = $connection->prepare($sql);
    $statement->execute();

    $result = $statement->fetchAll();
    echo "getting random number...";

    foreach ($result as $row)  {
        echo "<h1 style=font-size:125px;color:mediumvioletred>";
        echo $row['random'];
   }

  } catch(PDOException $error) {
      echo $sql . "<br>" . $error->getMessage();
}

?>
