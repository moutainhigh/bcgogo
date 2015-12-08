Ext.define('Ext.view.sys.user.Form', {
    extend:'Ext.form.Panel',
    bodyPadding:5,
    width:600,
    alias:'widget.formuser',
    store:'Ext.store.sys.Users',
    requires:[
        "Ext.view.sys.Status",
        "Ext.view.sys.userGroup.Select",
        'Ext.view.sys.department.DepartmentTreePicker',
        "Ext.store.sys.Departments"
    ],
    layout:'anchor',
    defaults:{
        anchor:'100%'
    },
    fieldDefaults:{
        labelWidth:125,
        msgTarget:'under',
        autoFitErrors:false
    },

    // Reset and Submit buttons
    buttons:[
        {
            id:"resetUserPassword",
            xtype:"button",
            tooltip:"默认密码：111111",
            text:'重置密码',
            action:'resetPassword'
        },
        {
            id:"formUserReset",
            text:'重置',
            tooltip:"重置",
            handler:function () {
                this.up("form").form.reset();
            }
        },
        {
            text:'保存',
            action:'save'
        }
    ],
    initComponent:function () {
        var me = this;
        me.addEvents('create');
        Ext.apply(me, {
            items:[
                {
                    layout:'column',
                    border:false,
                    items:[
                        {
                            columnWidth:.5,
                            border:false,
                            layout:'anchor',
                            defaultType:'textfield',
                            items:[
                                {
                                    id:'userNo',
                                    name:'userNo',
                                    fieldLabel:'账号',
                                    emptyText:"【英文字母、中文或是数字4-20位】",
                                    vtype:'userNo',
                                    minLength:4,
                                    minLengthText:"用户名不得小于4位",
                                    enforceMaxLength:true,
                                    maxLength:20,
                                    xtype:"textfield",
                                    allowBlank:false,
                                    validator:function (value) {        //validator 频繁触发 采用blur 触发validator
                                        return  !this.duplicating ? true : this.duplicating;
                                    }
                                },
                                {
                                    fieldLabel:'密码【大于6位】',
                                    minLength:6,
                                    minLengthText:"密码不得小于6位",
                                    name:'password',
                                    xtype:"textfield",
                                    inputType:'password',
                                    allowBlank:false
                                },
                                {
                                    fieldLabel:'姓名',
                                    name:'name',
                                    xtype:"textfield",
                                    allowBlank:false
                                },
                                {
                                    xtype:'departmentTreePicker',
                                    name:'occupationId',
                                    fieldLabel:'职位',
                                    allowBlank:false,
                                    displayField:'text'
                                },
                                {
                                    fieldLabel:'角色',
                                    name:'userGroupId',
                                    xtype:"userGroupSelect",
                                    allowBlank:false,
                                    valueField:'id',
                                    validator:function (value) {
                                        return (value === this.getValue()) ? '您输入的角色不正确！' : true;
                                    }
                                },
                                {
                                    fieldLabel:'状态',
                                    name:'statusEnum',
                                    xtype:"sysstatus",
                                    allowBlank:false
                                },
                                {
                                    xtype:"hiddenfield",
                                    name:'id'
                                },
                                {
                                    xtype:"hiddenfield",
                                    name:'userGroupName'
                                },
                                {
                                    id:'departmentId',
                                    xtype:"hiddenfield",
                                    name:'departmentId'
                                }
                            ]
                        },
                        {
                            columnWidth:.5,
                            border:false,
                            layout:'anchor',
                            defaultType:'textfield',
                            items:[
                                {
                                    fieldLabel:'手机号码',
                                    vtype:"mobilePhone",
                                    xtype:"textfield",
                                    enforceMaxLength:true,
                                    maxLength:11,
                                    name:'mobile'
                                },
                                {
                                    fieldLabel:'Email',
                                    vtype:'email',
                                    name:'email',
                                    xtype:"textfield"
                                },
                                {
                                    fieldLabel:'备注',
                                    emptyText:"【不超过100个字】",
                                    enforceMaxLength:true,
                                    maxLength:100,
                                    name:'memo',
                                    xtype:"textareafield"
                                }
                            ]
                        }
                    ]
                }
            ]
        });
        this.callParent();
    }
});