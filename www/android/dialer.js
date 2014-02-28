var exec = require("cordova/exec");
	var Dialer = function() {}; 
	//检验手机号码													
	function	isMobile(s)  										
	{																								
		var	reg0=	/^13\d{5,9}$/;												
		var	reg1=	/^153\d{4,8}$/;											
		var	reg2=	/^159\d{4,8}$/;
		var	reg3=	/^0\d{10,11}$/;	
		var	reg4=	/^18\d{9}$/;												
		var	my=	false;																								
		if(s!="")																
		{	
			if(reg0.test(s))my=true;												
			if(reg1.test(s))my=true;												
			if(reg2.test(s))my=true;												
			if(reg3.test(s))my=true;		
			if(reg4.test(s))my=true;																					
			if(!my)																				
			{																							
				alert('请输入正确手机号');																
			}																		
			else
				return my;
		}	
		else
		{
			alert("输入为空请输入数值");
			return my;	
		}									
	}  
// 检查固定电话的有效性											
	function isTel(s)												
	{		
		//区号加号码或者直接波本地号码，本地号码有7为的和8为的，区号有3位的和4位的																													
		var	pattern	=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;																													
		if(s!="")																	
		{																					
			if(!pattern.test(s))																					
			{																						
				alert('请输入正确的电话号码格式');																						
				return false;																			
			}	
			else
				return true	;															
		}		
		return false;													
	}
	//-------------------------------------------------------------------
	Dialer.prototype.call = function(number) {
	
	   // alert(number); 
		 exec(null, null, 'Dialer', 'call', [number]);
	 
	};
	module.exports =new Dialer();