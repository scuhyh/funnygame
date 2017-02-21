package org.igaming.funny.recognizer;

import java.util.List;

import com.igaming.common.bean.PokerCard;
import com.igaming.common.pokerhand.PokerHand;
import com.igaming.common.pokerhand.recognizer.PokerHandRecognizer;

/**
 * @Description:默认识别器
 * @author yunhong.he
 * @date 2017年2月20日 下午3:49:26
 */
public class DefaultRecognizer implements PokerHandRecognizer {

	@Override
	public void recoginze(List<PokerCard> usableCards) {
	}

	@Override
	public PokerHand getMaxPokerHand() {
		return null;
	}
}