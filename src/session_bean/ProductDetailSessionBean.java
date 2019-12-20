package session_bean;

import entity.ProductDetail;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class ProductDetailSessionBean extends AbstractSessionBean<ProductDetail> {

	@PersistenceContext(unitName = "Lab8a")
	private EntityManager em;

	public EntityManager getEntityManager() {
		return em;
	}

	public ProductDetailSessionBean() {
		super(ProductDetail.class);
	}
}