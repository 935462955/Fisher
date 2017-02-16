package entity;

public class Fish {
    
	private String name;
	private String [] localName;//别名有很多
	private String englishName;
	private String origin;//产地
	private String introduction;
	private String picture ;
	private String list;//目
	private String family;//科	
	private String category;//属
	
	
	
	public Fish(String name, String localName, String englishName, String origin, String introduction, String picture,
			String list, String family, String category) {
		super();
		this.name = name;
		String [] local = localName.split("、");
		this.localName = local;
		this.englishName = englishName;
		this.origin = origin;
		this.introduction = introduction;
		this.picture = picture;
		this.list = list;
		this.family = family;
		this.category = category;
	}
	public Fish(){
		
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocalNameByString() {
		String s = "";
		for(String x:localName )
			s =s+x;
	    return s;
	}
	public String [] getLocalName(){
		return localName;
	}
	public void setLocalName(String[] localName) {
		this.localName = localName;
	}
	public String getEnglishName() {
		return englishName;
	}
	public void setEnglishName(String englishName) {
		this.englishName = englishName;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getIntroduction() {
		return introduction;
	}
	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getList() {
		return list;
	}
	public void setList(String list) {
		this.list = list;
	}
	public String getFamily() {
		return family;
	}
	public void setFamily(String family) {
		this.family = family;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
}
