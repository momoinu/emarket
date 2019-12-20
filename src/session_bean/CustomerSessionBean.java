package session_bean;

import entity.Customer;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;


/**
 *
 * @author ThanDieu
 */
@Stateless
public class CustomerSessionBean extends AbstractSessionBean<Customer> {
	@PersistenceContext(unitName = "Lab8a")
	private EntityManager em;

	public EntityManager getEntityManager() {
		return em;
	}

	public CustomerSessionBean() {
		super(Customer.class);
	}
	
	public Customer findByUsername(String username) {
		
		
		return (Customer) em.createNamedQuery("Customer.findByUsername")
				.setParameter("username",username).getSingleResult();
		
//		List<Customer> customers =  em.createNamedQuery("Customer.findByUsername")
//				.setParameter("username",username).getResultList();
//	    if (customers.isEmpty()) {
//	        return null;
//	    }
//	    return customers.get(0);
 
    }
}
