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
		if (username == null)
			return false;
		if (receiver == null)
			return false;
		if (phone == null)
			return false;
		if (address == null)
			return false;
		if (ccNumber == null)
			return false;

		return true;
	}
}
