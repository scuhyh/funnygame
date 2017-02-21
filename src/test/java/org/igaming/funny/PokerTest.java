package org.igaming.funny;

import java.util.ArrayList;
import java.util.List;

import com.igaming.common.bean.PokerCard;
import com.igaming.common.bean.PokerCardPack;

/**
 * @Description:
 * @author yunhong.he
 * @date 2017年2月20日 下午2:48:32
 */
public class PokerTest {

	private static final int player_size = 4;
	private static final int count = 13;

	/**
	 * 
	 * @param args
	 */
	public static void main(String[] args) {
		PokerCardPack pack = PokerCardPack.createPack(false);
		// List<PokerCard> north = new ArrayList<PokerCard>();
		// List<PokerCard> east = new ArrayList<PokerCard>();
		// List<PokerCard> south = new ArrayList<PokerCard>();
		// List<PokerCard> west = new ArrayList<PokerCard>();
		// for (PokerCard card : pack.getPokerCards()) {
		// System.out.println(card);
		// }
		List<List<PokerCard>> list = new ArrayList<List<PokerCard>>();
		for (int i = 0; i < player_size; i++) {
			List<PokerCard> ll = new ArrayList<PokerCard>();
			list.add(ll);
			for (int j = 0; j < count; j++) {
				ll.add(pack.pickOneCard());
			}
		}
		//
		// System.out.println(pack.size());
		for (List<PokerCard> ll : list) {
			System.out.println("=============");
			for (PokerCard card : ll) {
				System.out.println(card);
			}
			System.out.println("=============");
		}
	}
}