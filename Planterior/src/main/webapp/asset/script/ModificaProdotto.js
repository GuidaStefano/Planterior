/**
 * 
 */
function chiudiElemento (bottone){
	 return function chiudi() {
		 bottone.classList.add("nascondi");
	 }
	}
	function apriElemento (bottone ){
		return function apri() {
			 bottone.classList.remove("nascondi");
		 } 
		 
	}
	
 