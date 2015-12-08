package com.bcgogo.driving.model;

import com.bcgogo.driving.model.base.LongIdentifier;
import com.bcgogo.pojox.api.AppUserCustomerDTO;
import com.bcgogo.pojox.enums.YesNo;

import javax.persistence.*;

/**
 * Created by IntelliJ IDEA.
 * Author: ndong
 * Date: 2015-11-26
 * Time: 10:10
 */
@Entity
@Table(name = "app_user_customer")
public class AppUserCustomer extends LongIdentifier {
  private String appUserNo;//手机端用户账号
  private Long customerId;//web客户id
  private Long shopId;//web客户的shopId
  private Long matchTime;//匹配时间
  private Long taskId;//app_user_customer_update_task表的id
  private Long shopVehicleId;
  private Long appVehicleId;
  private YesNo isMobileMatch;
  private YesNo isVehicleNoMatch;

  public AppUserCustomerDTO toDTO() {
    AppUserCustomerDTO dto = new AppUserCustomerDTO();
    dto.setId(getId());
    dto.setAppUserNo(getAppUserNo());
    dto.setCustomerId(getCustomerId());
    dto.setShopId(getShopId());
    dto.setMatchTime(getMatchTime());
    dto.setTaskId(getTaskId());
    dto.setShopVehicleId(getShopVehicleId());
    dto.setAppVehicleId(getAppVehicleId());
    dto.setIsMobileMatch(getIsMobileMatch());
    dto.setIsVehicleNoMatch(getIsVehicleNoMatch());
    return dto;
  }

  public void fromDTO(AppUserCustomerDTO appUserCustomerDTO) {
     if(appUserCustomerDTO != null){
       this.setId(appUserCustomerDTO.getId());
       this.setAppUserNo(appUserCustomerDTO.getAppUserNo());
       this.setCustomerId(appUserCustomerDTO.getCustomerId());
       this.setShopId(appUserCustomerDTO.getShopId());
       this.setMatchTime(appUserCustomerDTO.getMatchTime());
       this.setTaskId(appUserCustomerDTO.getTaskId());
       this.setShopVehicleId(appUserCustomerDTO.getShopVehicleId());
       this.setAppVehicleId(appUserCustomerDTO.getAppVehicleId());
       this.setIsMobileMatch(appUserCustomerDTO.getIsMobileMatch());
       this.setIsVehicleNoMatch(appUserCustomerDTO.getIsVehicleNoMatch());
     }
   }

  @Column(name = "app_user_no")
  public String getAppUserNo() {
    return appUserNo;
  }

  public void setAppUserNo(String appUserNo) {
    this.appUserNo = appUserNo;
  }

  @Column(name = "customer_id")
  public Long getCustomerId() {
    return customerId;
  }

  public void setCustomerId(Long customerId) {
    this.customerId = customerId;
  }

  @Column(name = "shop_id")
  public Long getShopId() {
    return shopId;
  }

  public void setShopId(Long shopId) {
    this.shopId = shopId;
  }


  @Column(name = "match_time")
  public Long getMatchTime() {
    return matchTime;
  }

  public void setMatchTime(Long matchTime) {
    this.matchTime = matchTime;
  }

  @Column(name = "task_id")
  public Long getTaskId() {
    return taskId;
  }

  public void setTaskId(Long taskId) {
    this.taskId = taskId;
  }

  @Column(name = "shop_vehicle_id")
  public Long getShopVehicleId() {
    return shopVehicleId;
  }

  public void setShopVehicleId(Long shopVehicleId) {
    this.shopVehicleId = shopVehicleId;
  }

  @Column(name = "app_vehicle_id")
  public Long getAppVehicleId() {
    return appVehicleId;
  }

  public void setAppVehicleId(Long appVehicleId) {
    this.appVehicleId = appVehicleId;
  }



  @Enumerated(EnumType.STRING)
  @Column(name = "is_mobile_match")
  public YesNo getIsMobileMatch() {
    return isMobileMatch;
  }

  public void setIsMobileMatch(YesNo isMobileMatch) {
    this.isMobileMatch = isMobileMatch;
  }

  @Enumerated(EnumType.STRING)
  @Column(name = "is_vehicle_no_match")
  public YesNo getIsVehicleNoMatch() {
    return isVehicleNoMatch;
  }

  public void setIsVehicleNoMatch(YesNo isVehicleNoMatch) {
    this.isVehicleNoMatch = isVehicleNoMatch;
  }



}
