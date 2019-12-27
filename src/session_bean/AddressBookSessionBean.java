package session_bean;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import entity.AddressBook;
import entity.CustomerOrder;

/**
 * Session Bean implementation class AddressBookSessionBean
 */
@Stateless
public class AddressBookSessionBean extends AbstractSessionBean {
	@PersistenceContext(unitName = "Lab8a")
	private EntityManager em;

	public EntityManager getEntityManager() {
		return em;
	}
       
    public AddressBookSessionBean() {
        super(AddressBook.class);
    }
    public List<AddressBook> findByCustomer(Object customer) {
		return em.createNamedQuery("AddressBook.findByCustomer").setParameter("customer", customer).getResultList();
	}
    public AddressBook findByAddressBookId(Object addressId) {
    	List<AddressBook> addressBooks = em.createNamedQuery("AddressBook.findByAddressBookId").setParameter("addressId", addressId).getResultList();
    	if(addressBooks == null) {
    		return null;
    	}
		return addressBooks.get(0);
	}

}
