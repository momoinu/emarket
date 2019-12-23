package session_bean;

import entity.CustomerOrder;

import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author ThanDieu
 */
@Stateless
public class CustomerOrderSessionBean extends AbstractSessionBean<CustomerOrder> {
	@PersistenceContext(unitName = "Lab8a")
	private EntityManager em;

	@Override
	public EntityManager getEntityManager() {
		return em;
	}

	public CustomerOrderSessionBean() {
		super(CustomerOrder.class);
	}

	public CustomerOrder find(Object id) {
		CustomerOrder order = em.find(CustomerOrder.class, id);
		em.refresh(order);
		return order;
	}

	public List<CustomerOrder> findByCustomer(Object customer) {
		return em.createNamedQuery("CustomerOrder.findByCustomer").setParameter("customer", customer)
				.getResultList();
	}
}