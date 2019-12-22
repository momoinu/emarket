package session_bean;

import java.util.List;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import entity.Category;
import entity.Customer;
import entity.Product;

@Stateless
public class ProductSessionBean extends AbstractSessionBean<Product> {

	@PersistenceContext(unitName = "Lab8a")
	private EntityManager em;
	@EJB
	private CategorySessionBean categorySB;
	public EntityManager getEntityManager() {
		return em;
	}

	public ProductSessionBean() {
		super(Product.class);
	}
	@Override
	public void remove(Product p) {
		//p = em.merge(p);
		Category c = categorySB.find(p.getCategory().getCategoryId());
		super.remove(p);	
		categorySB.getEntityManager().refresh(c);
//		c.removeProduct(p);
	}
	@Override 
	public void create(Product p) {
		super.create(p);
		Category c = categorySB.find(p.getCategory().getCategoryId());
//		c.addProduct(p);
		categorySB.getEntityManager().refresh(c);
	}	
	public Product findByName(String name) {
		
		
//		return (Customer) em.createNamedQuery("Customer.findByUsername")
//				.setParameter("username",username).getSingleResult();
		
		List<Product> products =  em.createNamedQuery("Product.findByName")
				.setParameter("name",name).getResultList();
	    if (products.isEmpty()) {
	        return null;
	    }
	    return products.get(0);
 
    }
}