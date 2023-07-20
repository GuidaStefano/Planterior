$(document).ready(function() {
	$('button[type=button][value=add]').on("click", function(){
		var productId = $(this).attr("name");
		var params = {
			id: productId,
			action: "add",
			ajax: true
		};
		ajaxCall(params);
	});
	
	$('button[type=button][value=meno]').on("click", function(){
		var productId = $(this).attr("name");
		var params = {
			id: productId,
			action: "remove",
			ajax: true
		};
		ajaxCall(params);
	});
});

function ajaxCall(params) {
	$.ajax({
		url: 'cart',
		method: 'GET',
		data: params,
		success: function(response) {
			var amount = parseInt(response.amount);
			var productPrice = parseFloat(response.productPrice).toFixed(2);
			var totalPrice = parseFloat(response.totalPrice).toFixed(2);
			
			if (amount < 1) {
				$("#product-" + params.id).remove();
				return;
			}
			
			if (response.isMaxAmount) {
				$("#error-" + params.id).css("display", "block");
				return;
			}
			
			$("#error-" + params.id).css("display", "none");
			
			$("#" + params.id).val(amount);
			$("#price-" + params.id).html(productPrice + "€");
			$("#total-price").html(totalPrice + "€");
		},
		error: function(xhr, status, error) {
			console.log(error);
		}	
	});
} 