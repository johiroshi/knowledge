<%@page import="org.support.project.common.util.NumberUtils"%>
<%@page import="org.support.project.knowledge.logic.KnowledgeLogic"%>
<%@page import="org.support.project.web.util.JspUtil"%>
<%@page pageEncoding="UTF-8" isELIgnored="false" session="false" errorPage="/WEB-INF/views/commons/errors/jsp_error.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<% JspUtil jspUtil = new JspUtil(request, pageContext); %>

<c:import url="/WEB-INF/views/commons/layout/layoutMain.jsp">

<c:param name="PARAM_HEAD">
<link rel="stylesheet" href="<%= request.getContextPath() %>/bower/bootstrap-tagsinput/dist/bootstrap-tagsinput.css" />
<link rel="stylesheet" href="<%= jspUtil.mustReloadFile("/css/knowledge-list.css") %>" />
</c:param>

<c:param name="PARAM_SCRIPTS">
<script type="text/javascript" src="<%= request.getContextPath() %>/bower/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/bower/echojs/dist/echo.min.js"></script>
<script type="text/javascript" src="<%= jspUtil.mustReloadFile("/js/knowledge-list.js") %>"></script>
</c:param>

<c:param name="PARAM_CONTENT">
<h4 class="title"><%= jspUtil.label("knowledge.list.title") %> <span style="font-size: 14px">page[<%= jspUtil.getValue("offset", Integer.class) + 1 %>]</span></h4>

	<c:if test="${!empty selectedTag || !empty selectedGroup || !empty selectedUser || !empty searchTags || !empty searchGroups || !empty keyword}">
		<div class="row">
			<div class="col-sm-12 selected_tag">
			
			<c:if test="${!empty selectedTag}">
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list?tag=<%=jspUtil.out("selectedTag.tagId") %>" >
					<i class="fa fa-tag"></i>&nbsp;<%=jspUtil.out("selectedTag.tagName") %>
			</a>
			</c:if>
			
			<c:if test="${!empty selectedGroup}">
			<a class="text-primary"
				href="<%= request.getContextPath() %>/open.knowledge/list?group=<%=jspUtil.out("selectedGroup.groupId") %>" >
					<i class="fa fa-group"></i>&nbsp;<%=jspUtil.out("selectedGroup.groupName") %>
			</a>
			</c:if>

			<c:if test="${!empty selectedUser}">
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list?user=<%= jspUtil.out("selectedUser.userId") %>" >
					<i class="fa fa-user"></i>&nbsp;<%= jspUtil.out("selectedUser.userName") %>
			</a>
			</c:if>
			
			<c:if test="${!empty searchTags}">
			<c:forEach var="searchTag" items="${searchTags}" varStatus="status">
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list?tag=<%=jspUtil.out("searchTag.tagId") %>" >
					<i class="fa fa-tag"></i>&nbsp;<%=jspUtil.out("searchTag.tagName") %>
			</a>
			</c:forEach>
			</c:if>

			<c:if test="${!empty searchGroups}">
			<c:forEach var="searchGroup" items="${searchGroups}" varStatus="status">
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list?group=<%=jspUtil.out("searchGroup.groupId") %>" >
					<i class="fa fa-group"></i>&nbsp;<%=jspUtil.out("searchGroup.groupName") %>
			</a>
			</c:forEach>
			</c:if>
			
			<c:if test="${!empty keyword}">
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list?keyword=<%=jspUtil.out("keyword") %>" >
					<i class="fa fa-search"></i>&nbsp;<%=jspUtil.out("keyword") %>
			</a>
			</c:if>
			
			
			<a class="text-primary" 
				href="<%= request.getContextPath() %>/open.knowledge/list" >
					<i class="fa fa-times-circle"></i>&nbsp;
			</a>
			</div>
		</div>
	</c:if>
	

		<nav>
			<ul class="pager">
				<li class="previous">
					<a href="<%= request.getContextPath() %>/open.knowledge/list/<%= jspUtil.out("previous") %><%= jspUtil.out("params") %>">
						<span aria-hidden="true">&larr;</span><%= jspUtil.label("label.previous") %>
					</a>
				</li>
				<li>
					<a href="<%= request.getContextPath() %>/protect.knowledge/view_add<%= jspUtil.out("params") %>" style="cursor: pointer;">
						<i class="fa fa-plus-circle"></i>&nbsp;<%= jspUtil.label("label.add") %>
					</a>
				</li>
				<li class="next">
					<a href="<%= request.getContextPath() %>/open.knowledge/list/<%= jspUtil.out("next") %><%= jspUtil.out("params") %>">
						<%= jspUtil.label("label.next") %> <span aria-hidden="true">&rarr;</span>
					</a>
				</li>
			</ul>
		</nav>

		<div class="row" id="knowledgeList">
			<div class="col-sm-12 col-md-8">
			<c:if test="${empty knowledges}">
			<%= jspUtil.label("knowledge.list.empty") %>
			</c:if>
			
			<c:forEach var="knowledge" items="${knowledges}" varStatus="status">
				<div class="thumbnail" 
					onclick="showKnowledge('<%= jspUtil.out("knowledge.knowledgeId") %>',
						'<%= jspUtil.out("offset") %>', '<%= jspUtil.out("keyword") %>',
						'<%= jspUtil.out("tag") %>', '<%= jspUtil.out("user") %>');">
					<div class="discription" id="discription_<%= jspUtil.out("knowledge.knowledgeId") %>"><i class="fa fa-check-square-o"></i>&nbsp;show!</div>
					<div class="caption">
						<h4>
						[<%= jspUtil.out("knowledge.knowledgeId") %>]&nbsp;
						<%= jspUtil.out("knowledge.title", JspUtil.ESCAPE_CLEAR) %>
						
						<%--
						<span class="score">
						<%if (jspUtil.getValue("knowledge.score", Float.class) > 0) { %>
						(<%= NumberUtils.NUMBER_FORMAT.format(jspUtil.getValue("knowledge.score", Float.class)) %>)
						<% } %>
						</span>
						--%>
						
						</h4>
						<p class="insert_info">
						<img src="<%= request.getContextPath()%>/images/loader.gif" 
							data-echo="<%= request.getContextPath()%>/open.account/icon/<%= jspUtil.out("knowledge.insertUser") %>" 
							alt="icon" width="36" height="36" style="float:left"/>
						<i class="fa fa-calendar" style="margin-left: 5px;"></i>&nbsp;<%= jspUtil.date("knowledge.updateDatetime")%>
						<br/>
						<i class="fa fa-user" style="margin-left: 5px;"></i>&nbsp;<%= jspUtil.out("knowledge.insertUserName") %>
						&nbsp;&nbsp;&nbsp;
						<i class="fa fa-thumbs-o-up" style="margin-left: 5px;"></i>&nbsp;× <span id="like_count"><%= jspUtil.out("knowledge.likeCount") %></span>
						&nbsp;&nbsp;&nbsp;
						<i class="fa fa-comments-o"></i>&nbsp;× <%= jspUtil.out("knowledge.commentCount") %>
						&nbsp;&nbsp;&nbsp;
						<%= jspUtil.is(String.valueOf(KnowledgeLogic.PUBLIC_FLAG_PUBLIC), "knowledge.publicFlag", 
								jspUtil.label("label.public.view")) %>
						<%= jspUtil.is(String.valueOf(KnowledgeLogic.PUBLIC_FLAG_PRIVATE), "knowledge.publicFlag", 
								jspUtil.label("label.private.view")) %>
						<%= jspUtil.is(String.valueOf(KnowledgeLogic.PUBLIC_FLAG_PROTECT), "knowledge.publicFlag", 
								jspUtil.label("label.protect.view")) %>
						<c:if test="${targets.containsKey(knowledge.knowledgeId)}">
							<c:forEach var="target" items="${ targets.get(knowledge.knowledgeId) }">
								<span class="tag label label-info"><%= jspUtil.out("target.label") %></span>
							</c:forEach>
						</c:if>
						&nbsp;&nbsp;&nbsp;
						<c:if test="${!empty knowledge.tagNames}">
							<i class="fa fa-tags"></i>
							<c:forEach var="tagName" items="${knowledge.tagNames.split(',')}">
								<span class="tag label label-info"><%= jspUtil.out("tagName") %></span>
							</c:forEach>
						</c:if>
						</p>
						<c:if test="${!empty keyword}">
						<p style="word-break:break-all" class="content">
						<%-- <c:out value="${knowledge.content}"></c:out>--%>
						<%= jspUtil.out("knowledge.content", JspUtil.ESCAPE_CLEAR, 300) %>
						</p>
						</c:if>
					</div>
				</div>
			</c:forEach>
			</div>
			
			<div class="col-sm-12 col-md-4">
			<h5>- <i class="fa fa-bolt"></i>&nbsp;<%= jspUtil.label("knowledge.list.menu") %> - </h5>
			<div class="list-group">
				<a class="list-group-item " 
				href="<%= request.getContextPath() %>/open.knowledge/list" >
					<i class="fa fa-list-alt"></i>&nbsp;<%= jspUtil.label("knowledge.list.menu.all") %>
				</a>
				<% if (!"".equals(jspUtil.id())) { %>
				<a class="list-group-item " 
				href="<%= request.getContextPath() %>/open.knowledge/list?user=<%= jspUtil.id() %>" >
					<i class="fa fa-male"></i>&nbsp;<%= jspUtil.label("knowledge.list.menu.myknowledge") %>
				</a>
				<% } %>
				<a class="list-group-item " 
				href="<%= request.getContextPath() %>/open.knowledge/search<%= jspUtil.out("params") %>" >
					<i class="glyphicon glyphicon-search"></i>&nbsp;<%= jspUtil.label("knowledge.list.menu.search") %>
				</a>
				<a class="list-group-item " 
					href="<%= request.getContextPath() %>/protect.knowledge/view_add<%= jspUtil.out("params") %>" 
					style="cursor: pointer;">
					<i class="fa fa-plus-circle"></i>&nbsp;<%= jspUtil.label("knowledge.list.menu.add") %>
				</a>
			</div>
			<br/>
			
			
			<h5>- <i class="fa fa-group"></i>&nbsp;<%= jspUtil.label("knowledge.navbar.config.group") %> - </h5>
			<c:choose>
			<c:when test="${groups != null}">
			<div class="list-group">
				<c:forEach var="group_item" items="${groups}">
				<a class="list-group-item"
					href="<%= request.getContextPath() %>/open.knowledge/list?group=<%= jspUtil.out("group_item.groupId") %>" >
					<span class="badge"><%= jspUtil.out("group_item.groupKnowledgeCount") %></span>
					<i class="fa fa-group"></i>&nbsp;<%= jspUtil.out("group_item.groupName") %>
				</a>
				</c:forEach>
			</div>
			<div style="width: 100%;text-align: right;">
				<a href="<%= request.getContextPath() %>/protect.group/mygroups">
					<i class="fa fa-group"></i>&nbsp;<%= jspUtil.label("knowledge.navbar.config.group.list") %>
				</a>&nbsp;&nbsp;&nbsp;
			</div>
	        </c:when>
	        <c:otherwise>
			<div class="list-group">
                <a class="list-group-item " href="<%= request.getContextPath() %>/protect.group/mygroups" style="cursor: pointer;">
	                <i class="fa fa-users"></i>&nbsp;<%= jspUtil.label("knowledge.navbar.config.group.list") %>
	            </a>
	        </div>
			</c:otherwise>
			</c:choose>
			<br/>
			
			<h5>- <i class="fa fa-tags"></i>&nbsp;<%= jspUtil.label("knowledge.list.popular.tags") %> - </h5>
			<div class="list-group">
			<c:forEach var="tag_item" items="${tags}">
				<a class="list-group-item"
					href="<%= request.getContextPath() %>/open.knowledge/list?tag=<%= jspUtil.out("tag_item.tagId") %>" >
					<span class="badge"><%= jspUtil.out("tag_item.knowledgeCount") %></span>
					<i class="fa fa-tag"></i>&nbsp;<%= jspUtil.out("tag_item.tagName") %>
				</a>
			</c:forEach>
			</div>
			<div style="width: 100%;text-align: right;">
				<a href="<%= request.getContextPath() %>/open.tag/list">
					<i class="fa fa-tags"></i>&nbsp;<%= jspUtil.label("knowledge.list.tags.list") %>
				</a>&nbsp;&nbsp;&nbsp;
			</div>
			
			<h5>- <i class="fa fa-history"></i>&nbsp;<%= jspUtil.label("knowledge.list.history") %> - </h5>
			<div class="list-group">
			<c:forEach var="history" items="${histories}">
				<a href="<%= request.getContextPath() %>/open.knowledge/view/<%= jspUtil.out("history.knowledgeId") %><%= jspUtil.out("params") %>" 
				class="list-group-item">
					<h5 class="list-group-item-heading"><i class="fa fa-history"></i>&nbsp;
					[<%= jspUtil.out("history.knowledgeId") %>]&nbsp;<%= jspUtil.out("history.title") %></h5>
					<p class="list-group-item-text">
					<%= jspUtil.out("history.content", 0, 40) %>
					</p>
				</a>
			</c:forEach>
			</div>
			
			
			<%--
			<h5>- Popular Knowledge - </h5>
			表示回数のをとっておき、回数が多いものを表示
			（履歴データを期間で範囲指定してカウントする）
			 --%>
			
			</div>
		
		</div>
		
		<nav>
			<ul class="pager">
				<li class="previous">
					<a href="<%= request.getContextPath() %>/open.knowledge/list/<%= jspUtil.out("previous") %><%= jspUtil.out("params") %> %>">
						<span aria-hidden="true">&larr;</span><%= jspUtil.label("label.previous") %>
					</a>
				</li>
				<li>
					<a href="<%= request.getContextPath() %>/protect.knowledge/view_add<%= jspUtil.out("params") %>" style="cursor: pointer;">
						<i class="fa fa-plus-circle"></i>&nbsp;<%= jspUtil.label("label.add") %>
					</a>
				</li>
				<li class="next">
					<a href="<%= request.getContextPath() %>/open.knowledge/list/<%= jspUtil.out("next") %><%= jspUtil.out("params") %>">
						<%= jspUtil.label("label.next") %> <span aria-hidden="true">&rarr;</span>
					</a>
				</li>
			</ul>
		</nav>

</c:param>

</c:import>

