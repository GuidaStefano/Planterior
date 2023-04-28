package it.unisa.planterior.model.bean;

public class Prodotto {
	
	private long id;
	private String nome;
	private Sottocategoria categoria;
	private String descrizioneBreve;
	private String descrizioneCompleta;
	private String consigliMantenimento;
	private String condizioniLuce;
	private float altezza;
	private float circonferenzaVaso;
	private String immagineCopertina;
	private String[] immagini;
	private float prezzoBase;
	private float scontoPercentuale;
	private float prezzo;
	
	public Prodotto() {
		
	}
	
	public Prodotto(String nome, Sottocategoria categoria, String descrizioneBreve, String descrizioneCompleta, String consigliMantenimento,
			String condizioniLuce, float altezza, float circonferenzaVaso, String immagineCopertina, String[] immagini, float prezzoBase, float scontoPercentuale) {
		id = -1; // generato dal DBMS
		this.nome = nome;
		this.categoria = categoria;
		this.descrizioneBreve = descrizioneBreve;
		this.descrizioneCompleta = descrizioneCompleta;
		this.consigliMantenimento = consigliMantenimento;
		this.condizioniLuce = condizioniLuce;
		this.altezza = altezza;
		this.circonferenzaVaso = circonferenzaVaso;
		this.immagineCopertina = immagineCopertina;
		this.immagini = immagini;
		this.prezzoBase = prezzoBase;
		this.scontoPercentuale = scontoPercentuale;
		prezzo = prezzoBase - (prezzoBase / 100 * scontoPercentuale);
	}
	
	public long getId() {
		return id;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public Sottocategoria getCategoria() {
		return categoria;
	}
	
	public void setCategoria(Sottocategoria categoria) {
		this.categoria = categoria;
	}
	
	public String getDescrizioneBreve() {
		return descrizioneBreve;
	}
	
	public void setDescrizioneBreve(String descrizioneBreve) {
		this.descrizioneBreve = descrizioneBreve;
	}
	
	public String getDescrizioneCompleta() {
		return descrizioneCompleta;
	}
	
	public void setDescrizioneCompleta(String descrizioneCompleta) {
		this.descrizioneCompleta = descrizioneCompleta;
	}
	
	public String getConsigliMantenimento() {
		return consigliMantenimento;
	}
	
	public void setConsigliMantenimento(String consigliMantenimento) {
		this.consigliMantenimento = consigliMantenimento;
	}
	
	public String getCondizioniLuce() {
		return condizioniLuce;
	}
	
	public void setCondizioniLuce(String condizioniLuce) {
		this.condizioniLuce = condizioniLuce;
	}
	
	public float getAltezza() {
		return altezza;
	}
	
	public void setAltezza(float altezza) {
		this.altezza = altezza;
	}
	
	public float getCirconferenzaVaso() {
		return circonferenzaVaso;
	}
	
	public void setCirconferenzaVaso(float circonferenzaVaso) {
		this.circonferenzaVaso = circonferenzaVaso;
	}
	
	public String getImmagineCopertina() {
		return immagineCopertina;
	}
	
	public void setImmagineCopertina(String immagineCopertina) {
		this.immagineCopertina = immagineCopertina;
	}
	
	public String[] getImmagini() {
		return immagini;
	}
	
	public void setImmagini(String[] immagini) {
		this.immagini = immagini;
	}
	
	public float getPrezzoBase() {
		return prezzoBase;
	}
	
	public void setPrezzoBase(float prezzoBase) {
		this.prezzoBase = prezzoBase;
	}
	
	public float getScontoPercentuale() {
		return scontoPercentuale;
	}
	
	public void setScontoPercentuale(float scontoPercentuale) {
		this.scontoPercentuale = scontoPercentuale;
	}
	
	public float getPrezzo() {
		return prezzo;
	}
	
	public void setPrezzo(float prezzo) {
		this.prezzo = prezzo;
	}
	
	enum Categoria {
		PIANTE_DA_INTERNO,
		TERRARIUM,
		HOME_DECOR
	}
	
	enum Sottocategoria {
		PIANTE_VERDI(Categoria.PIANTE_DA_INTERNO),
		PIANTE_GRASSE(Categoria.PIANTE_DA_INTERNO),
		BONSAI(Categoria.PIANTE_DA_INTERNO),
		PIANTE_FIORITE(Categoria.PIANTE_DA_INTERNO),
		ORCHIDEE(Categoria.PIANTE_DA_INTERNO),
		TERRARIUM(Categoria.TERRARIUM),
		VASI(Categoria.HOME_DECOR),
		ACCESSORI_PIANTE(Categoria.HOME_DECOR);
		
		private Categoria nodo;
		
		private Sottocategoria(Categoria nodo) {
			this.nodo = nodo;
		}
		
		public Categoria getNodo() {
			return nodo;
		}
	}

}
