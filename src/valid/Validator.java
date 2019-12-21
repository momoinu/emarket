package valid;

public class Validator {
	public Validator() {
		
	}
	public boolean isNumberic(String str) { 
		  try {  
		    Double.parseDouble(str);  
		    return true;
		  } catch(NumberFormatException e){  
		    return false;  
		  }  
		}
	public boolean validateForm(String username,String receiver, String phone, String address, String ccNumber) {
		if (username.equals(""))
			return false;
		if (receiver.equals(""))
			return false;
		if (phone.equals(""))
			return false;
		if (address.equals(""))
			return false;
		if (ccNumber.equals(""))
			return false;

		return true;
	}
}
