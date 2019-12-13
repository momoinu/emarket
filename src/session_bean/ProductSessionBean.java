package session_bean;

import entity.Product;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class ProductSessionBean extends AbstractSessionBean<Product> {

	@PersistenceContext(unitName = "Lap8a")
	private EntityManager em;

	protected EntityManager getEntityManager() {
		return em;
	}

	public ProductSessionBean() {
		super(Product.class);
	}
}