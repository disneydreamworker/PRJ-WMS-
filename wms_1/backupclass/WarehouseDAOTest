package main.java.com.ssg.dao.warehouse;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;

import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Properties;
import javax.xml.transform.Result;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

public class WarehouseDAOTest {
  public static String DRIVER;
  public static String URL;
  public static String USER;
  public static String PASSWORD;
  private static Connection connection;

  @BeforeAll
  static void setUp() throws Exception {
    //Connection 사전 작업
    Properties properties = new Properties();
    FileReader fr = new FileReader("resource/database.properties");
    properties.load(fr);

    DRIVER = properties.getProperty("driver");
    URL = properties.getProperty("url");
    USER = properties.getProperty("user");
    PASSWORD = properties.getProperty("password");

    Class.forName(DRIVER);
    connection = DriverManager.getConnection(URL, USER, PASSWORD);
  }

  @AfterAll
  static void close() throws Exception {
    //모든 테스트 실행 후 Connection 닫기
    if (connection != null && !connection.isClosed()) {
      connection.close();
    }
  }

  @Test
  void testConnection() throws Exception {
    //커넥션 테스트 실행
    assertNotNull(connection);
  }


  //Read
  @Test
  void testReadWarehouse() throws Exception {
    String query = "select * from warehouse";
    PreparedStatement ps = connection.prepareStatement(query);
    ResultSet rs = ps.executeQuery();
    while(rs.next()) {
      int wId = rs.getInt("w_id");
      String wName = rs.getString("w_name");
      String location = rs.getString("location");
      int locationId = rs.getInt("location_id");
      float totalAreaSqm = rs.getFloat("total_area_sqm");
      float generalWsqm = rs.getFloat("general_w_sqm");
      float coldWsqm = rs.getFloat("cold_w_sqm");
      float storageWsqm = rs.getFloat("storage_w_sqm");
      float portWsqm = rs.getFloat("port_w_sqm");
      float bondedWsqm = rs.getFloat("bonded_w_sqm");
      float chemicalWsqm = rs.getFloat("chemical_w_sqm");
      float foodColdWsqm = rs.getFloat("food_cold_w_sqm");
      float livestockWsqm = rs.getFloat("livestock_w_sqm");
      float marineColdWsqm = rs.getFloat("marine_cold_w_sqm");
      String relatedLaw = rs.getString("related_law");
      String handledItems = rs.getString("handled_items");
      String manager = rs.getString("manager");
      Timestamp regiDate = rs.getTimestamp("regi_date");
      int employeesNumber = rs.getInt("employees_number");
      String facilityEquipment = rs.getString("facility_equipment");
      String contactNumber = rs.getString("contact_number");
    }
  }


  //Insert
  @Test
  void testCreateWarehouse() throws Exception{


  }
  @Test
  void testCreateSubWarehouse() throws Exception{}
  @Test
  void testCreateSubSectionWarehouse() throws Exception{}



  //Update
  @Test
  void testUpdateWarehouse() throws Exception{}
  @Test
  void testUpdateSubWarehouse() throws Exception{}
  @Test
  void testUpdateSubSectionWarehouse() throws Exception{}


  //Delete
  @Test
  void testDeleteSubSectionWarehouse() throws Exception{
    String query = "truncate table ss_warehouse";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.executeQuery();
  }

}
