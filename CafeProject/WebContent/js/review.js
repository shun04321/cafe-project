function validate(){
		var star = document.getElementById("5-stars");
		var isChecked;
		
		if(star[i].checked)
			isChecked=true;
		
		if(isChecked)
			return true;
		else
			alert('별점을 체크하세요 :)');
		return false;		
	}