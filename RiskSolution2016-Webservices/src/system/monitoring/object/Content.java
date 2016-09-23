package system.monitoring.object;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class Content {
	private String key;
	private String content;

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
