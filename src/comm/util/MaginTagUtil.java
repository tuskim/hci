package comm.util;

/**
 * 가우스 레포트 태그문에서 사용.
 * @author ymkang
 *
 */
public class MaginTagUtil {

	public int offset = 0;

	public int set(int adder) {
		offset += adder;
		return offset;
	}

	public int get() {
		return offset;
	}

	public int zero() {
		offset = 0;
		return offset;
	}
}
