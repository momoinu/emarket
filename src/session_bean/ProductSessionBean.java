package session_bean;

import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import entity.Category;
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
}