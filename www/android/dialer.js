var exec = require("cordova/exec");
	var Dialer = function() {}; 
	//�����ֻ�����													
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
				alert('��������ȷ�ֻ���');																
			}																		
			else
				return my;
		}	
		else
		{
			alert("����Ϊ����������ֵ");
			return my;	
		}									
	}  
// ���̶��绰����Ч��											
	function isTel(s)												
	{		
		//���żӺ������ֱ�Ӳ����غ��룬���غ�����7Ϊ�ĺ�8Ϊ�ģ�������3λ�ĺ�4λ��																													
		var	pattern	=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;																													
		if(s!="")																	
		{																					
			if(!pattern.test(s))																					
			{																						
				alert('��������ȷ�ĵ绰�����ʽ');																						
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