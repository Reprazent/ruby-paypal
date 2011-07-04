require 'pp'
require 'test/unit'
require 'lib/ruby-paypal/paypal'
require 'lib/ruby-paypal/credit_card_checks'


class RubyPayPal < Test::Unit::TestCase 
  def setup
    @test_data = {"visa" => "4154727623381301", "visa" => "4015262522324137", "visa" => "4574806205610007"}    
    @paypal = Paypal.new('css.pa_1195828529_biz_api1.gmail.com', '1195828547', 'AJsoTDMhNESFz43L9WKtkP2tVCZZAZ3Wl.IxVLj8IfJQsjg8WZYMENpS')
  end

  def test_do_direct_payment_sale 
#    resp = @paypal.do_direct_payment_sale('202.156.13.1', '14.34', 'visa', '4574806205610007', '022017', 'Test', 'User')
#    assert_equal("Success", resp.ack) 
  end

  def test_luhn_check
    @test_data.each { |type, number|
      assert_equal(@paypal.luhn_check(number), true)      
    }
  end
  
  def test_card_type_check
    @test_data.each { |type, number|
      assert_equal(@paypal.card_type_check(type,number), true)
    }
  end

  def test_do_direct_payment_authorization

  end

  def test_do_mass_payment
    payments = []
    payment = PayPalPayment.new
    payment.email = 'css.pa_1195828513_per@gmail.com'
    payment.unique_id = '123'
    payment.note = 'Hello there'
    payment.amount = '5'
    payments << payment

    payment2 = PayPalPayment.new
    payment2.email = 'css.pa_1195828286_per@gmail.com'
    payment2.unique_id = '124'
    payment2.note = 'Hello there2'
    payment2.amount = '15'
    
    payments << payment2
    
    resp = @paypal.do_mass_payment(payments, "hello world")
    assert_equal("Success", resp.ack)
  end


end 

