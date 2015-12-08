/**
 * @author zhangjuntao
 * 权限维护模块 view 入口
 */
Ext.define('Ext.view.dataMaintenance.permission.PermissionView', {
    extend:'Ext.tab.Panel',
    alias:'widget.dataMaintenancePermissionView',
    forceFit:true,
    frame:true,
    autoHeight:true,
    autoScroll:true,
    requires:[
        'Ext.view.dataMaintenance.permission.RoleResources',
        'Ext.view.dataMaintenance.permission.ResourceList',
        'Ext.view.dataMaintenance.permission.ResourceRoleWindow',
        'Ext.view.dataMaintenance.permission.ShopVersionList',
        'Ext.view.dataMaintenance.permission.AddUserGroupWindow',
        'Ext.view.dataMaintenance.permission.AddResourceWindow',
        'Ext.view.dataMaintenance.permission.UserGroupList',
        'Ext.view.dataMaintenance.permission.ModuleTree',
        'Ext.view.dataMaintenance.permission.RoleTreeForUserGroup',
        'Ext.view.dataMaintenance.permission.RoleTreeForShopType'
    ],
    items:[
        {
            title:'版本维护',
            bodyBorder:false,
            hideBorders:true,
            defaults:{
                split:true,
                animFloat:false,
                autoHide:false,
                useSplitTips:true
            },
            layout:'border',
            items:[
                {
                    region:'west',
                    width:500,
                    split:true,
                    layout:'border',
                    items:[
                        {
                            region:'center',
                            height:200,
                            title:'版本维护',
                            xtype:"permissionShopVersionList"
                        },
                        {
                            region:'south',
                            height:200,
                            title:'版本所含用户组',
                            xtype:"permissionUserGroupList"
                        }
                    ]
                },
                {
                    region:'center',
                    split:true,
                    layout:'border',
                    items:[
                        {
                            region:'center',
                            title:'版本所含角色',
                            xtype:"roleTreeForShopType"
                        },
                        {
                            region:'east',
                            width:250,
                            title:'用户组所含角色',
                            collapsible:true,
                            xtype:'roleTreeForUserGroup'
                        }
                    ]
                }
            ]
        },
        {
            title:'模块-角色-资源维护',
            layout:'border',
            bodyBorder:true,
            hideBorders:true,
            id:'moduleTreeView',
            defaults:{
                collapsible:true,
                split:true,
                animFloat:false,
                autoHide:false,
                useSplitTips:true
            },
            items:[
                {
                    region:'west',
                    xtype:'moduleTree',
                    width:300,
                    collapsible:true,
                    split:true
                },
                {
                    hideHeaders:true,
                    preventHeader:true,
                    region:'center',
                    layout:'border',
                    defaults:{
                        split:true,
                        animFloat:false,
                        autoHide:false,
                        useSplitTips:true
                    },
                    items:[
                        {
                           //所有权限列表（增删改查、添加到role或module）
                            region:'center',
                            xtype:'permissionResourceList'
                        },
                        {
                            collapsible:true,
                            region:'south',
                            height:200,
                            //role与resource的关联关系
                            xtype:"permissionRoleResources"
                        }
                    ]
                }
            ]
        }/*,
        {
            title:'资源维护',
            hideBorders:true,
            xtype:'permissionResourceList'
        }*/
    ],
    initComponent:function () {
        var me = this;

        me.callParent();
    }

});