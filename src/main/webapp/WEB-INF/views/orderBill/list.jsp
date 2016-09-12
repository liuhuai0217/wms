<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/style/basic_layout.css" rel="stylesheet" type="text/css">
    <link href="/style/common_style.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="/js/jquery/jquery.js"></script>
    <script type="text/javascript" src="/js/plugins/jquery.artDialog.js?skin=blue"></script>
    <script type="text/javascript" src="/js/commonAll.js"></script>
    <script language="javascript" type="text/javascript" src="/js/plugins/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
    	$(function(){
    		$("input[name='qo.beginTime']").addClass('Wdate').click(function(){
    			WdatePicker({
    				skin:'whyGreen',
    				maxDate:$("input[name='qo.endTime']").val()||new Date()
    			});
    		})
    		$("input[name='qo.endTime']").addClass('Wdate').click(function(){
    			WdatePicker({
    				skin:'whyGreen',
    				minDate:$("input[name='qo.beginTime']").val()
    			});
    		})
    	})
    </script>
    <title>WMS-采购单管理</title>
    <style>
        .alt td {
            background: black !important;
        }
    </style>
</head>
<body>
<!--====================================-->
<%@include file="/WEB-INF/views/common/common_msg.jsp"%>
<!--====================================-->
<s:form id="searchForm" namespace="/" action="orderBill" method="post">
    <div id="container">
        <div class="ui_content">
            <div class="ui_text_indent">
                <div id="box_border">
                    <div id="box_top">搜索</div>
                    <div id="box_center">
							业务时间
							<s:textfield name="qo.beginTime" class="ui_input_txt02"/>-
							<s:textfield name="qo.endTime" class="ui_input_txt02"/>
							供应商
							<s:select list="#suppliers" name="qo.supplierid" listKey="id" listValue="name"
								headerKey="-1" headerValue="全部" cssClass="ui_select01"
							></s:select>
							采购单状态
							<s:select list="#{'-1':'全部','0':'未审核','1':'已审核'}" name="qo.status" cssClass="ui_select01"/>
						</div>
                    <div id="box_bottom">
                   		<input type="button" value="查询" class="ui_input_btn01 btn_page"/>
                        <input type="button" value="新增" class="ui_input_btn01 btn_input" data-url="<s:url namespace="/" action="orderBill_input"/>"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui_content">
            <div class="ui_tb">
                <table class="table" cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
                    <tr>
                        <th width="30"><input type="checkbox" id="all"/></th>
                        <th>订单编号</th>
                        <th>业务时间</th>
                        <th>供应商</th>
                        <th>采购总数量</th>
                        <th>采购总金额</th>
                        <th>制单人</th>
                        <th>审核人</th>
                        <th>审核状态</th>
                        <th></th>
                    </tr>
                    <tbody>
                    <s:iterator value="#pageResult.pageResult">
                        <tr>
                            <td><input type="checkbox" name="IDCheck" autocomplete="off" class="acb" data-eid="<s:property value="id"/>"/></td>
                                <td><s:property value="sn"/></td>
                                <td><s:property value="inputTime"/></td>
                                <td><s:property value="supplier.name"/></td>
                                <td><s:property value="totalNumber"/></td>
                                <td><s:property value="totalAmout"/></td>
                                <td><s:property value="inputUser.name"/></td>
                                <td><s:property value="auditor.name"/></td>
                                <td>
	                              <s:if test="status == 0"><span style="color: green">未审核</span>
	                              
	                              </s:if>
	                               <s:if test="status == 1"><span style="color: red">已审核</span></s:if>
                                </td>
                             <s:if test="status==0">
	                            <td>
	                            	<s:a namespace="/" action="orderBill_audit">
	                            		<s:param name="orderBill.id" value="id"/>
	                            	审核</s:a>
	                            	<!-- 一般的操作 编辑和删除 -->
	                                <s:url var="editUrl" namespace="/" action="orderBill_input">
	                                    <s:param name="orderBill.id" value="id"/>
	                                </s:url>
	                                <a href="<s:property value="#editUrl"/>">编辑</a>
	
	                                <s:url var="deleteUrl" namespace="/" action="orderBill_delete">
	                                    <s:param name="orderBill.id" value="id"/>
	                                </s:url>
	                                <a href="javascript:;" class="btn_delete" data-url='<s:property value="#deleteUrl"/>'>删除</a>
	                            </td>
                             </s:if>
                             <!-- 如果该采购单已经审核 那么只能查看该单 -->
                             <s:else>
	                             <td>
		                              <s:url var="editUrl" namespace="/" action="orderBill_show">
			                                    <s:param name="orderBill.id" value="id"/>
			                          </s:url>
			                          <a href="<s:property value="#editUrl"/>">查看</a>
		                          </td>
                             </s:else>
                        </tr>
                    </s:iterator>
                    </tbody>
                </table>
            </div>
            <!--引入分页条-->
            <%@include file="/WEB-INF/views/common/common.jsp"%>
        </div>
    </div>
</s:form>
</body>
</html>
