package main.java.com.ssg.dto;

import java.sql.Timestamp;
import lombok.Data;

@Data
public class Warehouse {
  private int wId;
  private String wName;
  private String location;
  private int locationId;
  private float totalAreaSqm;
  private float generalWsqm;
  private float coldWsqm;
  private float storageWsqm;
  private float portWsqm;
  private float bondedWsqm;
  private float chemicalWsqm;
  private float foodColdWsqm;
  private float livestockWsqm;
  private float marineColdWsqm;
  private String relatedLaw;
  private String handledItems;
  private String manager;
  private Timestamp regiDate;
  private int employeesNumber;
  private String facilityEquipment;
  private String contactNumber;
}
