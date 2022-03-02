function detailChangeView(value){
			if(value=="0")
				location.href="./../index/index.jsp";
			else if(value=="1")
				location.href="index.jsp?contentPage=test.jsp";
			else if(value=="2")
				location.href="index.jsp?contentPage=./../product/menu.jsp";
			else if(value=="3")
				location.href="index.jsp?contentPage=test.jsp";
		}
		
function sort(value){
			if(value=="coffee_asc")
				location.href="index.jsp?contentPage=./../product/coffee_asc.jsp";
			else if(value=="coffee_desc")
				location.href="index.jsp?contentPage=./../product/coffee_desc.jsp";
			else if(value=="dessert_asc")
				location.href="index.jsp?contentPage=./../product/dessert_asc.jsp";
			else if(value=="dessert_desc")
				location.href="index.jsp?contentPage=./../product/dessert_desc.jsp";

		}