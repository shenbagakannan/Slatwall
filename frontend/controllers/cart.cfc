/*

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

*/
component persistent="false" accessors="true" output="false" extends="BaseController" {

	property name="orderService" type="any";
	property name="productService" type="any";
	property name="promotionService" type="any";
	property name="skuService" type="any";
	property name="utilityFormService" type="any";
	
	// This method is deprecated as of 7/19/2011, the new method is clearCart
	public void function clearItems(required struct rc) {
		clearCart(rc);
	}
	
	public void function clearCart(required struct rc) {
		getOrderService().clearCart();	
		
		getFW().redirectExact(rc.$.createHREF(filename='shopping-cart'));
	}
	
	public void function update(required struct rc) {
		
		// Conditional logic to see if we should use the deprecated method
		if(isArray(rc.orderItems)) {
			getOrderService().saveOrder(rc.$.slatwall.cart(), rc);
		} else if (isStruct(rc.orderItems)) {
			// This is the deprecated method
			getOrderService().updateOrderItems(order=rc.$.slatwall.cart(), data=rc);	
		}
				
		getFW().setView("frontend:cart.detail");
	}
	
	public void function addItem(required struct rc) {
		param name="rc.skuID" default="";
		param name="rc.productID" default="";
		param name="rc.selectedOptions" default="";
		param name="rc.quantity" default=1;
		
		var sku = getSkuService().getSku(rc.skuID);
		
		if(isNull(sku)) {
			var product = getProductService().getProduct(rc.productID);
			if(!isNull(product)) {
				if(rc.selectedOptions != "") {
					var sku = product.getSkuBySelectedOptions(rc.selectedOptions);
				} else if (arrayLen(product.getSkus()) == 1) {
					var sku = product.getSkus()[1];
				}	
			}
		}
		
		if(!isNull(sku)) {
			// Persist the Current Order by setting it in the session
			rc.$.slatwall.session().setOrder(rc.$.slatwall.cart());
			
			// Build up any possible product customizations
			var cusomtizationData = getUtilityFormService().buildFormCollections(rc);
			
			// Add to the cart() order the new sku with quantity and shipping id
			getOrderService().addOrderItem(order=rc.$.slatwall.cart(), sku=sku, quantity=rc.quantity, customizatonData=cusomtizationData);
		}
		
		getFW().redirectExact(rc.$.createHREF(filename='shopping-cart'), false);
	}
	
	public void function removeItem(required struct rc) {
		param name="rc.orderItemID" default="";
		
		getOrderService().removeOrderItem(order=rc.$.slatwall.cart(), orderItemID=rc.orderItemID);
		
		getFW().redirectExact(rc.$.createHREF(filename='shopping-cart'), false);
	}
	
	public void function addPromotionCode(required struct rc) {
		param name="rc.promotionCode" default="";
		param name="rc.promotionCodeOK" default="true";
		
		var pc = getPromotionService().getPromotionCodeByPromotionCode(rc.promotionCode);
		
		if(!isNull(pc) && pc.getPromotion().getActiveFlag()) {
			getOrderService().addPromotionCode(order=rc.$.slatwall.cart(), promotionCode=pc);
		} else {
			rc.promotionCodeOK = false;
		}
		
		getFW().setView("frontend:cart.detail");
	}
	
	public void function removePromotionCode(required struct rc) {
		param name="rc.promotionCodeID" default="";
		
		var pc = getPromotionService().getPromotionCode(rc.promotionCodeID, true);
		
		getOrderService().removePromotionCode(order=rc.$.slatwall.cart(), promotionCode=pc);
		
		getFW().setView("frontend:cart.detail");
	}
	
}
