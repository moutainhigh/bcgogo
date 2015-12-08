package com.bcgogo.txn.model;

import com.bcgogo.BooleanEnum;
import com.bcgogo.enums.OtherIncomeCalculateWay;
import com.bcgogo.model.LongIdentifier;
import com.bcgogo.txn.dto.RepairOrderOtherIncomeItemDTO;
import com.bcgogo.utils.NumberUtil;
import com.bcgogo.utils.StringUtil;
import org.apache.commons.collections.CollectionUtils;

import javax.persistence.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: cfl
 * Date: 12-12-12
 * Time: 下午4:40
 * To change this template use File | Settings | File Templates.
 */
@Entity
@Table(name="repair_order_other_income_item")
public class RepairOrderOtherIncomeItem extends LongIdentifier{
  private Long shopId;
  private Long orderId;
  private String name;
  private String memo;
  private Double price;
  private Double costPrice;
  private BooleanEnum calculateCostPrice;

  private OtherIncomeCalculateWay otherIncomeCalculateWay;//施工单其他费用 材料管理费 计算方式
  private Double otherIncomePriceRate;//施工单其他费用 材料管理费 计算比率



  @Column(name="cost_price")
  public Double getCostPrice() {
    return costPrice;
  }

  public void setCostPrice(Double costPrice) {
    this.costPrice = costPrice;
  }

  @Column(name="calculate_cost_price")
  @Enumerated(EnumType.STRING)
  public BooleanEnum getCalculateCostPrice() {
    return calculateCostPrice;
  }

  public void setCalculateCostPrice(BooleanEnum calculateCostPrice) {
    this.calculateCostPrice = calculateCostPrice;
  }

  @Column(name="shop_id")
  public Long getShopId() {
    return shopId;
  }

  public void setShopId(Long shopId) {
    this.shopId = shopId;
  }

  @Column(name="order_id")
  public Long getOrderId() {
    return orderId;
  }

  public void setOrderId(Long orderId) {
    this.orderId = orderId;
  }

  @Column(name="name")
  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  @Column(name="memo")
  public String getMemo() {
    return memo;
  }

  public void setMemo(String memo) {
    this.memo = memo;
  }

  @Column(name="price")
  public Double getPrice() {
    return price;
  }

  public void setPrice(Double price) {
    this.price = price;
  }

  @Column(name="other_income_calculate_way")
  @Enumerated(EnumType.STRING)
  public OtherIncomeCalculateWay getOtherIncomeCalculateWay() {
    return otherIncomeCalculateWay;
  }

  public void setOtherIncomeCalculateWay(OtherIncomeCalculateWay otherIncomeCalculateWay) {
    this.otherIncomeCalculateWay = otherIncomeCalculateWay;
  }

  @Column(name = "other_income_price_rate")
  public Double getOtherIncomePriceRate() {
    return otherIncomePriceRate;
  }

  public void setOtherIncomePriceRate(Double otherIncomePriceRate) {
    this.otherIncomePriceRate = otherIncomePriceRate;
  }

  public RepairOrderOtherIncomeItem(){
  }

  public RepairOrderOtherIncomeItem(RepairOrderOtherIncomeItemDTO itemDTO) {
    if (null != itemDTO) {
      this.setMemo(itemDTO.getMemo());
      this.setName(itemDTO.getName());
      this.setOrderId(itemDTO.getOrderId());
      this.setPrice(itemDTO.getPrice());
      this.setShopId(itemDTO.getShopId());
      this.setId(itemDTO.getId());
      this.setOtherIncomeCalculateWay(itemDTO.getOtherIncomeCalculateWay());
      this.setOtherIncomePriceRate(NumberUtil.doubleVal(itemDTO.getOtherIncomeRate()));

      if (itemDTO.getOtherIncomeCostPrice() == null) {
        this.setCalculateCostPrice(BooleanEnum.FALSE);
      } else {
        this.setCalculateCostPrice(BooleanEnum.TRUE);
      }
      this.setCostPrice(NumberUtil.doubleVal(itemDTO.getOtherIncomeCostPrice()));
    }


  }

  public void fromDTO(RepairOrderOtherIncomeItemDTO itemDTO)
  {
    if(null != itemDTO)
    {
      this.setMemo(itemDTO.getMemo());
      this.setName(itemDTO.getName());
      this.setOrderId(itemDTO.getOrderId());
      this.setPrice(itemDTO.getPrice());
      this.setShopId(itemDTO.getShopId());
      this.setId(itemDTO.getId());
      this.setOtherIncomeCalculateWay(itemDTO.getOtherIncomeCalculateWay());
      this.setOtherIncomePriceRate(NumberUtil.doubleVal(itemDTO.getOtherIncomeRate()));

      if (itemDTO.getOtherIncomeCostPrice() == null) {
        this.setCalculateCostPrice(BooleanEnum.FALSE);
      } else {
        this.setCalculateCostPrice(BooleanEnum.TRUE);
      }
      this.setCostPrice(NumberUtil.doubleVal(itemDTO.getOtherIncomeCostPrice()));
    }
  }

  public RepairOrderOtherIncomeItemDTO toDTO()
  {
    RepairOrderOtherIncomeItemDTO itemDTO = new RepairOrderOtherIncomeItemDTO();
    itemDTO.setId(this.getId());
    itemDTO.setShopId(this.getShopId());
    itemDTO.setMemo(this.getMemo());
    itemDTO.setPrice(this.getPrice());
    itemDTO.setName(this.getName());
    itemDTO.setOrderId(this.getOrderId());
    itemDTO.setCalculateCostPrice(getCalculateCostPrice() == null?null:getCalculateCostPrice().name());

    if(this.getCalculateCostPrice() == BooleanEnum.TRUE){
      itemDTO.setOtherIncomeCostPrice(getCostPrice());
    }
    itemDTO.setOtherIncomeCalculateWay(getOtherIncomeCalculateWay());
    itemDTO.setOtherIncomeRate(getOtherIncomePriceRate());
    return itemDTO;
  }

  public static Map<Long,RepairOrderOtherIncomeItem> listToMap(List<RepairOrderOtherIncomeItem> itemList)
  {
    Map<Long,RepairOrderOtherIncomeItem> otherIncomeItemMap = new HashMap<Long, RepairOrderOtherIncomeItem>();
    if(CollectionUtils.isNotEmpty(itemList))
    {
      for(RepairOrderOtherIncomeItem item : itemList)
      {
        otherIncomeItemMap.put(item.getId(),item);
      }
    }

    return otherIncomeItemMap;
  }
}
