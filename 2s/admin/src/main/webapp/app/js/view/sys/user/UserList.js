Ext.define('Ext.view.sys.user.UserList', {
    extend:'Ext.grid.Panel',
    alias:'widget.sysuserlist',
    store:'Ext.store.sys.Users',
    autoScroll:true,
    columnLines:true,
    stripeRows:true,            //每列是否是斑马线分开
//    enableKeyNav:true,          //允许键盘操作，即上下左右移动选中点
    forceFit:true,              //自动填充，即让所有列填充满gird宽度
    multiSelect:true,           //可以多选
    autoHeight:true,
    requires:[
        "Ext.view.sys.Status",
        'Ext.view.sys.department.DepartmentTreePicker',
        'Ext.view.sys.userGroup.Select'
    ],
    dockedItems:[
        {
            xtype:'toolbar',
            dock:'top',
            id:'searchUserComponent',
            items:[
                {
                    xtype:"textfield",
                    emptyText:"账号",
                    width:100,
                    id:'searchUserNo'
                },
                {
                    xtype:"textfield",
                    emptyText:"姓名",
                    width:100,
                    id:'searchName'
                },
                {
                    width:80,
                    id:'searchStatus',
                    xtype:"sysstatus"
                },
                {
                    valueField: 'name',
                    width:100,
                    id:'searchRoleName',
                    xtype:"userGroupSelect"
                },
                {
                    xtype:'departmentTreePicker',
                    id:'departmentTreePicker',
                    emptyText:"部门或职位"
                },
                "-",
                {
                    text:"查询",
                    xtype:'button',
                    action:'search',
                    iconCls:"icon-search",
                    tooltip:"根据条件查询用户信息",
                    scope:this
                }
            ]
        },
        {
            dock:'bottom',
            xtype:'pagingtoolbar',
            store:'Ext.store.sys.Users',
            displayInfo:true
        },
        {
            xtype:'toolbar',
            items:[
                {
                    text:'新增',
                    xtype:'button',
                    tooltip:'新增角色',
                    action:'addUser',
                    scope:this,
                    iconCls:'icon-add'
                },
                '-',
                {
                    text:'删除',
                    xtype:'button',
                    tooltip:'删除',
                    id:'delUsersButton',
                    action:'delUsers',
                    scope:this,
                    iconCls:'icon-del',
                    disabled:true
                },
                '-',
                {
                    text:'启用',
                    xtype:'button',
                    id:'enableUsersButton',
                    tooltip:'开启用户',
                    iconCls:'icon-edit',
                    action:'enableUsers',
                    scope:this,
                    disabled:true
                },
                '-',
                {
                    id:'forbiddenUsersButton',
                    text:'禁用',
                    xtype:'button',
                    tooltip:'禁用用户',
                    iconCls:'icon-del',
                    action:'forbiddenUsers',
                    disabled:true,
                    scope:this
                }
            ]
        }
    ],
    initComponent:function () {
        var me = this;
        var permissionUtils = Ext.create("Ext.utils.PermissionUtils");
        Ext.apply(me, {
            selModel:Ext.create('Ext.selection.CheckboxModel', {}),
            columns:[
                {
                    header:'No.',
                    xtype:'rownumberer',
                    sortable:false,
                    width:25
                },
                {
                    header:'账号',
                    dataIndex:'userNo'
                },
                {
                    header:'姓名',
                    dataIndex:'name'
                },
                {
                    header:'手机',
                    dataIndex:'mobile'
                },
                {
                    header:'E-Mail',
                    dataIndex:'email',
                    renderer: function (value, metadata) {
                        metadata.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {
                    header:'部门',
                    dataIndex:'departmentName'
                },
                {
                    header:'职位',
                    dataIndex:'occupationName'
                },
                {
                    header:'角色',
                    dataIndex:'userGroupId',
                    renderer:function (val, style, rec, index) {
                        return  rec.data.userGroupName;
                    },
                    sortable:true
                },
                {
                    header:'状态',
                    dataIndex:'statusEnum',
                    renderer:function (val) {
                        return Ext.widget("sysstatus").getDisplayName(val)
                    },
                    sortable:true
                },
                {
                    xtype:'actioncolumn',
                    header:'操作',
                    width:60,
                    items:[
                        {
                            text:'编辑',
                            tooltip:'编辑用户',
                            scope:me,
                            icon:'app/images/icons/edit.png'
                        },
                        {
                            text:'删除',
                            tooltip:'删除用户',
                            scope:me,
                            icon:'app/images/icons/delete.png'
                        }
                    ]
                }
            ]
        });
        this.callParent(arguments);
    }
});
