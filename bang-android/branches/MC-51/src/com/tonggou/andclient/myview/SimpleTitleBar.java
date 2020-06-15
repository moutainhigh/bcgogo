package com.tonggou.andclient.myview;

import android.content.Context;
import android.graphics.Color;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ProgressBar;
import android.widget.ImageView.ScaleType;
import android.widget.TextView;

import com.tonggou.andclient.R;

/**
 * �򵥵ı��������� �Զ��� ActionBar��
 * 
 * @author lwz
 */
public class SimpleTitleBar extends FrameLayout {
	private ViewGroup mTitleBarContainer;	// ����������������
	private ImageButton mLeftButton;		// ��������ߵİ�ť��һ��Ϊ���ؼ�
	private Button mRightButton;			// �������ұߵİ�ť���ð�ť�����ּӱ�����
	private ImageButton mRightImageButton;	// �������ұߵĴ�ͼƬ��ť
	private TextView mTitle;				// �������ı���
	private ProgressBar mLoadingIndicator;	// ���ڼ���ָʾ��
	
	public SimpleTitleBar(Context context) {
		super(context);
		init();
	}
	
	public SimpleTitleBar(Context context, AttributeSet attrs) {
		super(context, attrs);
		init();
	}
	
	public SimpleTitleBar(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		init();
	}
	
	private void init() {
		mTitleBarContainer = (ViewGroup) View.inflate(getContext(), R.layout.widget_simple_titlebar, null);
		super.addView(mTitleBarContainer);
		mLeftButton = (ImageButton)mTitleBarContainer.findViewById(R.id.titlebar_left_btn);
		mRightButton = (Button)mTitleBarContainer.findViewById(R.id.titlebar_right_btn);
		mTitle = (TextView)mTitleBarContainer.findViewById(R.id.titlebar_title);
		mLoadingIndicator = (ProgressBar)mTitleBarContainer.findViewById(R.id.load_progress);
		
		mLeftButton.setVisibility(View.GONE);
		mRightButton.setVisibility(View.GONE);
		hideLoadingIndicator();
	}
	
	/**
	 * ��������Լ�
	 * @return
	 */
	private SimpleTitleBar self() {
		return this;
	}
	
	/**
	 * ���ñ�������
	 * @param titleRes
	 * @return
	 */
	public SimpleTitleBar setTitle(int titleRes) {
		if( titleRes >0 ) mTitle.setText(titleRes);
		return self();
	}
	
	/**
	 * ���ñ�������
	 * @param title �ַ���
	 * @return
	 */
	public SimpleTitleBar setTitle(String title) {
		setTitle(title, Color.WHITE);
		return self();
	}
	
	/**
	 * ���ñ��������Լ���ɫ
	 * @param title
	 * @param color
	 * @return
	 */
	public SimpleTitleBar setTitle( String title, int color ){
		if( ! TextUtils.isEmpty(title) ) {
			mTitle.setText(title);
		}
		mTitle.setTextColor(color);
		return self();
	}
	
	/**
	 * ������߰�ť��ʾ��ͼƬ
	 * @param backgroundRes ������ԴͼƬ
	 * @return
	 */
	public SimpleTitleBar setLeftButton(int backgroundRes) {
		if( backgroundRes > 0 ) {
			mLeftButton.setImageResource(backgroundRes);
		}
		return self();
	}
	
	/**
	 * �����ұ߰�ť��ʾ�ı���ͼƬ
	 * @param backgroundRes ������ԴͼƬ
	 * @return
	 */
	public SimpleTitleBar setRightButton( int backgroundRes) {
		if( backgroundRes > 0 ) {
			mRightButton.setBackgroundResource(backgroundRes);
		}
		
		return self();
	}
	
	/**
	 * �����ұ߰�ť����
	 * @param textRes
	 * @return
	 */
	public SimpleTitleBar setRightButtonText(int textRes) {
		if( textRes > 0 ) mRightButton.setText(textRes);
		return self();
	}
	
	/**
	 * �����ұ߰�ť��ʾ������
	 * @param text ��ť��ʾ������
	 * @return
	 */
	public SimpleTitleBar setRightButtonText( String text) {
		if( ! TextUtils.isEmpty(text) ) {
			mRightButton.setText(text);
		}
		return self();
	}
	
	/**
	 * �����ұ߰�ť��ʾ�����ּ�����ͼƬ
	 * @param backgroundRes ������ԴͼƬ
	 * @return
	 */
	public SimpleTitleBar setRightButton(String text, int backgroundRes) {
		setRightButtonText(text);
		setRightButton(backgroundRes);
		return self();
	}
	
	/**
	 * �����ұ�ͼƬ��ť
	 * @param imageRes src      ������Ϊ 0 ʱ�������ø�ͼƬ
	 * @param backgroundRes ����    ������Ϊ 0 ʱ�������ø�ͼƬ
	 * @return
	 */
	public SimpleTitleBar setRightImageButton(int imageRes, int backgroundRes) {
		mRightImageButton = new ImageButton(getContext());
		mRightButton.setVisibility(View.GONE);
		if( imageRes > 0 )  mRightImageButton.setImageResource(imageRes);
		if( backgroundRes > 0 )  mRightImageButton.setBackgroundResource(backgroundRes);
		mRightImageButton.setLayoutParams(mRightButton.getLayoutParams());
		mRightImageButton.setScaleType(ScaleType.FIT_CENTER);
		mTitleBarContainer.addView(mRightImageButton);
		return self();
	}
	
	/**
	 * ��߰�ť�������
	 * @param l
	 * @return
	 */
	public SimpleTitleBar setOnLeftButtonClickListener(View.OnClickListener l){
		if( l != null ) {
			mLeftButton.setOnClickListener(l);
			mLeftButton.setVisibility(View.VISIBLE);
		}
		
		return self();
	}
	
	/**
	 * �ұ߱߰�ť�������
	 * @param l
	 * @return
	 */
	public SimpleTitleBar setOnRightButtonClickListener(View.OnClickListener l){
		if( l != null ) {
			if( mRightImageButton == null ) {
				mRightButton.setOnClickListener(l);
				mRightButton.setVisibility(View.VISIBLE);
			} else {
				mRightImageButton.setOnClickListener(l);
			}
		}
		return self();
	}
	
	/**
	 * ��ʾ����ָʾ��
	 */
	public void showLoadingIndicator() {
		mLoadingIndicator.setVisibility(View.VISIBLE);
	}
	
	/**
	 * ���ؼ���ָʾ��
	 */
	public void hideLoadingIndicator() {
		mLoadingIndicator.setVisibility(View.GONE);
	}
	
	/**
	 * ������߰�ť
	 */
	public void hideLeftButton() {
		mLeftButton.setVisibility(View.GONE);
	}
	
	/**
	 * �����ұ߰�ť
	 */
	public void hideRightButton() {
		mRightButton.setVisibility(View.GONE);
		mRightImageButton.setVisibility(View.GONE);
	}
}