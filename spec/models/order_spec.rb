require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'format' do
      it 'CEP de entrega deve conter somente números' do
        # Arrange
        order = Order.new(delivery_postal_code: '5HBf9CIu')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :delivery_postal_code).to be true
      end

      it 'CEP de retirada deve conter somente números' do
        # Arrange
        order = Order.new(pick_up_postal_code: '5HBf9CIu')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :pick_up_postal_code).to be true
      end

      it 'CPF do destinatário deve conter somente números' do
        # Arrange
        order = Order.new(recipient_cpf: '5HBf9CIufu5')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_cpf).to be true
      end

      it 'e-mail do destinatário deve ser um e-mail' do
        # Arrange
        order = Order.new(recipient_email: 'denise.com')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_email).to be true
      end

      it 'telefone do destinatário deve conter somente números' do
        # Arrange
        order = Order.new(recipient_phone_number: '5HBf9CIuf')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_phone_number).to be true
      end
    end
    
    context 'length' do
      it 'CEP de entrega deve ter 8 dígitos' do
         # Arrange
         order = Order.new(delivery_postal_code: '12345678')

         # Act
         order.valid?
 
         # Assert
         expect(order.errors.include? :delivery_postal_code).to be false
      end

      it 'CEP de entrega não deve ter mais que 8 dígitos' do
        # Arrange
        order = Order.new(delivery_postal_code: '123456789')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :delivery_postal_code).to be true
      end

      it 'CEP de entrega não deve ter menos que 8 dígitos' do
        # Arrange
        order = Order.new(delivery_postal_code: '1234567')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :delivery_postal_code).to be true
     end

      it 'CEP de retirada deve ter 8 dígitos' do
        # Arrange
        order = Order.new(pick_up_postal_code: '12345678')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :pick_up_postal_code).to be false
     end

      it 'CEP de retirada não deve ter mais que 8 dígitos' do
        # Arrange
        order = Order.new(pick_up_postal_code: '123456789')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :pick_up_postal_code).to be true
      end

      it 'CEP de retirada não deve ter menos que 8 dígitos' do
        # Arrange
        order = Order.new(pick_up_postal_code: '1234567')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :pick_up_postal_code).to be true
      end

      it 'CPF do destinatário deve ter 11 dígitos' do
        # Arrange
        order = Order.new(recipient_cpf: '12345678901')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_cpf).to be false
      end

      it 'CPF do destinatário não deve ter mais que 11 dígitos' do
        # Arrange
        order = Order.new(recipient_cpf: '123456789012')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_cpf).to be true
      end

      it 'CPF do destinatário não deve ter menos que 11 dígitos' do
        # Arrange
        order = Order.new(recipient_cpf: '1234567890')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_cpf).to be true
      end

      it 'telefone do destinatário não deve ter mais que 11 dígitos' do
        # Arrange
        order = Order.new(recipient_phone_number: '123456789012')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_phone_number).to be true
      end

      it 'telefone do destinatário não deve ter menos que 10 dígitos' do
        # Arrange
        order = Order.new(recipient_phone_number: '123456789')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_phone_number).to be true
      end

      it 'telefone do destinatário pode ter 10 dígitos' do
        # Arrange
        order = Order.new(recipient_phone_number: '1234567890')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_phone_number).to be false
      end

      it 'telefone do destinatário pode ter 11 dígitos' do
        # Arrange
        order = Order.new(recipient_phone_number: '12345678901')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :recipient_phone_number).to be false
      end

      it 'SKU deve ter 20 dígitos' do
        # Arrange
        order = Order.new(sku: 'TV32P-SAMSUNG-XPTO90')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :sku).to be false
      end

      it 'SKU não deve ter mais que 20 dígitos' do
        # Arrange
        order = Order.new(sku: 'TV32P-SAMSUNG-XPTO901')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :sku).to be true
      end

      it 'SKU não deve ter menos que 20 dígitos' do
        # Arrange
        order = Order.new(sku: 'TV32P-SAMSUNG-XPTO9')

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :sku).to be true
      end
    end

    context 'numericality' do
      it 'distância deve ser maior que 0' do
        # Arrange
        order = Order.new(distance: 1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :distance).to be false
      end

      it 'distância não deve ser igual a 0' do
        # Arrange
        order = Order.new(distance: 0)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :distance).to be true
      end

      it 'distância não deve ser menor que 0' do
        # Arrange
        order = Order.new(distance: -1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :distance).to be true
      end

      it 'altura deve ser maior que 0' do
        # Arrange
        order = Order.new(height: 1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :height).to be false
      end

      it 'altura não deve ser igual a 0' do
        # Arrange
        order = Order.new(height: 0)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :height).to be true
      end

      it 'altura não deve ser menor que 0' do
        # Arrange
        order = Order.new(height: -1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :height).to be true
      end

      it 'comprimento deve ser maior que 0' do
        # Arrange
        order = Order.new(length: 1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :length).to be false
      end

      it 'comprimento não deve ser igual a 0' do
        # Arrange
        order = Order.new(length: 0)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :length).to be true
      end

      it 'comprimento não deve ser menor que 0' do
        # Arrange
        order = Order.new(length: -1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :length).to be true
      end

      it 'largura deve ser maior que 0' do
        # Arrange
        order = Order.new(width: 1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :width).to be false
      end

      it 'largura não deve ser igual a 0' do
        # Arrange
        order = Order.new(width: 0)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :width).to be true
      end
      
      it 'largura não deve ser menor que 0' do
        # Arrange
        order = Order.new(width: -1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :width).to be true
      end

      it 'peso deve ser maior que 0' do
        # Arrange
        order = Order.new(weight: 1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :weight).to be false
      end

      it 'peso não deve ser igual a 0' do
        # Arrange
        order = Order.new(weight: 0)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :weight).to be true
      end

      it 'peso não deve ser menor que 0' do
        # Arrange
        order = Order.new(weight: -1)

        # Act
        order.valid?

        # Assert
        expect(order.errors.include? :weight).to be true
      end
    end
    
    context 'presence' do
      it 'endereço de entrega é obrigatório' do
        # Arrange
        order = Order.new(delivery_address: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:delivery_address]).to include('não pode ficar em branco')
      end

      it 'cidade de entrega é obrigatório' do
        # Arrange
        order = Order.new(delivery_city: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:delivery_city]).to include('não pode ficar em branco')
      end

      it 'estado de entrega é obrigatório' do
        # Arrange
        order = Order.new(delivery_state: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:delivery_state]).to include('não pode ficar em branco')
      end

      it 'CEP de entrega é obrigatório' do
        # Arrange
        order = Order.new(delivery_postal_code: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:delivery_postal_code]).to include('não pode ficar em branco')
      end

      it 'destinatário é obrigatório' do
        # Arrange
        order = Order.new(recipient: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:recipient]).to include('não pode ficar em branco')
      end

      it 'CPF do destinatário é obrigatório' do
        # Arrange
        order = Order.new(recipient_cpf: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:recipient_cpf]).to include('não pode ficar em branco')
      end

      it 'e-mail do destinatário é obrigatório' do
        # Arrange
        order = Order.new(recipient_email: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:recipient_email]).to include('não pode ficar em branco')
      end

      it 'telefone do destinatário é obrigatório' do
        # Arrange
        order = Order.new(recipient_phone_number: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:recipient_phone_number]).to include('não pode ficar em branco')
      end

      it 'endereço de retirada é obrigatório' do
        # Arrange
        order = Order.new(pick_up_address: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:pick_up_address]).to include('não pode ficar em branco')
      end

      it 'cidade de retirada é obrigatório' do
        # Arrange
        order = Order.new(pick_up_city: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:pick_up_city]).to include('não pode ficar em branco')
      end

      it 'estado de retirada é obrigatório' do
        # Arrange
        order = Order.new(pick_up_state: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:pick_up_state]).to include('não pode ficar em branco')
      end

      it 'CEP de retirada é obrigatório' do
        # Arrange
        order = Order.new(pick_up_postal_code: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:pick_up_postal_code]).to include('não pode ficar em branco')
      end

      it 'SKU é obrigatório' do
        # Arrange
        order = Order.new(sku: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:sku]).to include('não pode ficar em branco')
      end

      it 'altura é obrigatório' do
        # Arrange
        order = Order.new(height: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:height]).to include('não pode ficar em branco')
      end

      it 'largura é obrigatório' do
        # Arrange
        order = Order.new(width: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:width]).to include('não pode ficar em branco')
      end

      it 'comprimento é obrigatório' do
        # Arrange
        order = Order.new(length: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:length]).to include('não pode ficar em branco')
      end

      it 'peso é obrigatório' do
        # Arrange
        order = Order.new(weight: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:weight]).to include('não pode ficar em branco')
      end

      it 'distância é obrigatório' do
        # Arrange
        order = Order.new(distance: '')

        # Act
        order.valid?

        # Assert
        expect(order.errors[:distance]).to include('não pode ficar em branco')
      end
    end
  end

  describe '#destination_city_and_state' do
    it 'exibe o nome da cidade e estado de destino' do
      # Arrange
      order = Order.new(delivery_city: 'Rio de Janeiro', delivery_state: 'RJ')

      # Act

      # Assert
      expect(order.destination_city_and_state).to eq 'Rio de Janeiro - RJ'
    end
  end

  describe '#dimensions' do
    it 'exibe comprimento, largura e altura do produto' do
      # Arrange
      order = Order.new(length: 100, width: 70, height: 50)

      # Act

      # Assert
      expect(order.dimensions).to eq '100 cm x 70 cm x 50 cm'
    end
  end

  describe '#formatted_delivery_postal_code' do
    it 'exibe o CEP de entrega formatado' do
      # Arrange
      order = Order.new(delivery_postal_code: '12345678')

      # Act

      # Assert
      expect(order.formatted_delivery_postal_code).to eq '12.345-678'
    end
  end

  describe '#formatted_pick_up_postal_code' do
    it 'exibe o CEP de retirada formatado' do
      # Arrange
      order = Order.new(pick_up_postal_code: '12345678')

      # Act

      # Assert
      expect(order.formatted_pick_up_postal_code).to eq '12.345-678'
    end
  end
  
  describe '#formatted_cpf' do
    it 'exibe o CPF do destinatário formatado' do
      # Arrange
      order = Order.new(recipient_cpf: '12345678901')

      # Act

      # Assert
      expect(order.formatted_cpf).to eq '123.456.789-01'
    end
  end

  describe '#formatted_phone_number' do
    it 'exibe o telefone de 11 dígitos do destinatário formatado' do
      # Arrange
      order = Order.new(recipient_phone_number: '12345678901')

      # Act

      # Assert
      expect(order.formatted_phone_number).to eq '(12) 34567-8901'
    end

    it 'exibe o telefone de 10 dígitos do destinatário formatado' do
      # Arrange
      order = Order.new(recipient_phone_number: '1234567890')

      # Act

      # Assert
      expect(order.formatted_phone_number).to eq '(12) 3456-7890'
    end
  end

  describe '#full_delivery_address' do
    it 'exibe o endereço, cidade e estado de entrega' do
      # Arrange
      order = Order.new(delivery_address: 'Estrada do Porto, 70', delivery_city: 'Santo André', delivery_state: 'SP')

      # Act

      # Assert
      expect(order.full_delivery_address).to eq 'Estrada do Porto, 70 - Santo André - SP'
    end
  end

  describe '#full_pick_up_address' do
    it 'exibe o endereço, cidade e estado de retirada' do
      # Arrange
      order = Order.new(pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'Santo André', pick_up_state: 'SP')

      # Act

      # Assert
      expect(order.full_pick_up_address).to eq 'Estrada do Porto, 70 - Santo André - SP'
    end
  end

  describe '#origin_city_and_state' do
    it 'exibe o nome da cidade e estado de origem' do
      # Arrange
      order = Order.new(pick_up_city: 'São Paulo', pick_up_state: 'SP')

      # Act

      # Assert
      expect(order.origin_city_and_state).to eq 'São Paulo - SP'
    end
  end

  describe '#pending?' do
    it 'a ordem de serviço é criada como pendente' do
      # Arrange
      order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                            delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                            recipient_email: 'denise@email.com', recipient_phone_number: '00000000000', 
                            pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                            pick_up_postal_code: '30000000', sku: '00000000000000000000', height: 60, width: 40, length: 100, 
                            weight: 300, distance: 60)

      # Act
      
      # Assert
      expect(order.pending?).to be true
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar uma ordem de serviço' do
      # Arrange
      order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                            delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                            recipient_email: 'denise@email.com', recipient_phone_number: '00000000000', 
                            pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                            pick_up_postal_code: '30000000', sku: '00000000000000000000', height: 60, width: 40, length: 100, 
                            weight: 300, distance: 60)
      
      # Act

      # Assert
      expect(order.tracking_code.length).to eq 15
    end

    it 'e o código é único' do
      # Arrange
      first_order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                                  delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                                  recipient_email: 'denise@email.com', recipient_phone_number: '00000000000', 
                                  pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                                  pick_up_postal_code: '30000000', sku: '00000000000000000000', height: 60, width: 40, length: 100, 
                                  weight: 300, distance: 60)

      second_order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                                   delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                                   recipient_email: 'denise@email.com', recipient_phone_number: '00000000000', 
                                   pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                                   pick_up_postal_code: '30000000', sku: '11100000000000000000', height: 50, width: 30, length: 130, 
                                   weight: 400, distance: 60)    

      # Act

      # Assert
      expect(second_order.tracking_code).not_to eq first_order.tracking_code
    end
  end

  describe '#search_prices' do
    it 'encontra os preços por peso para uma ordem de serviço' do
      # Arrange
      so_a = ShippingOption.create!(name: 'Entrega Expressa', min_distance: 50 , max_distance: 600, min_weight: 1_000, max_weight: 50_000, 
                                    delivery_fee: 5.50, status: :enabled)
      so_b = ShippingOption.create!(name: 'Entrega Básica', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)

      price_a = Price.create!(min_weight: 1_000, max_weight: 2_000, price_per_km: 3.00, shipping_option: so_a)
      price_aa = Price.create!(min_weight: 2_001, max_weight: 4_000, price_per_km: 1.00, shipping_option: so_a)

      price_b = Price.create!(min_weight: 1_500, max_weight: 2_000, price_per_km: 3.50, shipping_option: so_b)
      price_bb = Price.create!(min_weight: 3_000, max_weight: 4_000, price_per_km: 1.50, shipping_option: so_b)

      order = Order.new(weight: 3_000)

      # Act

      # Assert
      expect(order.search_prices).to eq [price_aa, price_bb]
    end
  end

  describe '#search_deadlines' do
    it 'encontra os prazos para uma ordem de serviço' do
      # Arrange
      so_a = ShippingOption.create!(name: 'Entrega Expressa', min_distance: 50 , max_distance: 600, min_weight: 1_000, max_weight: 50_000, 
                                    delivery_fee: 5.50, status: :enabled)
      so_b = ShippingOption.create!(name: 'Entrega Básica', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)

      deadline_a = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 30, shipping_option: so_a)
      deadline_aa = Deadline.create!(min_distance: 201, max_distance: 400, deadline: 48, shipping_option: so_a)

      deadline_b = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 20, shipping_option: so_b)
      deadline_bb = Deadline.create!(min_distance: 300, max_distance: 400, deadline: 40, shipping_option: so_b)

      order = Order.new(distance: 300)

      # Act

      # Assert
      expect(order.search_deadlines).to eq [deadline_aa, deadline_bb]
    end
  end

  describe '#search_distance_fees' do
    it 'encontra as taxas por distância para uma ordem de serviço' do
      # Arrange
      so_a = ShippingOption.create!(name: 'Entrega Expressa', min_distance: 50 , max_distance: 600, min_weight: 1_000, max_weight: 50_000, 
                                    delivery_fee: 5.50, status: :enabled)
      so_b = ShippingOption.create!(name: 'Entrega Básica', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)

      distance_fee_a = DistanceFee.create!(min_distance: 50, max_distance: 200, fee: 2.00, shipping_option: so_a)
      distance_fee_aa = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 2.50, shipping_option: so_a)

      distance_fee_b = DistanceFee.create!(min_distance: 30, max_distance: 200, fee: 1.00, shipping_option: so_b)
      distance_fee_bb = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 1.50, shipping_option: so_b)

      order = Order.new(distance: 300)

      # Act

      # Assert
      expect(order.search_distance_fees).to eq [distance_fee_aa, distance_fee_bb]
    end
  end

  describe '#generate_quotations' do
    it 'retorna um array de hashs com orçamentos e prazos para uma ordem de serviço' do
      # Arrange
      so_a = ShippingOption.create!(name: 'Entrega Expressa', min_distance: 50 , max_distance: 600, min_weight: 1_000, 
                                               max_weight: 50_000, delivery_fee: 5.50, status: :enabled)
      so_b = ShippingOption.create!(name: 'Entrega Básica', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)
      so_c = ShippingOption.create!(name: 'Outra Entrega', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)

      price_a = Price.create!(min_weight: 1_000, max_weight: 2_000, price_per_km: 3.00, shipping_option: so_a)
      price_aa = Price.create!(min_weight: 2_001, max_weight: 4_000, price_per_km: 1.00, shipping_option: so_a)
      distance_fee_a = DistanceFee.create!(min_distance: 50, max_distance: 200, fee: 2.00, shipping_option: so_a)
      distance_fee_aa = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 2.50, shipping_option: so_a)
      deadline_a = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 30, shipping_option: so_a)
      deadline_aa = Deadline.create!(min_distance: 201, max_distance: 400, deadline: 48, shipping_option: so_a)

      price_b = Price.create!(min_weight: 1_500, max_weight: 2_000, price_per_km: 3.50, shipping_option: so_b)
      price_bb = Price.create!(min_weight: 3_000, max_weight: 4_000, price_per_km: 1.50, shipping_option: so_b)
      distance_fee_b = DistanceFee.create!(min_distance: 30, max_distance: 200, fee: 1.00, shipping_option: so_b)
      distance_fee_bb = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 1.50, shipping_option: so_b)
      deadline_b = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 20, shipping_option: so_b)
      deadline_bb = Deadline.create!(min_distance: 300, max_distance: 400, deadline: 40, shipping_option: so_b)

      Price.create!(min_weight: 4_500, max_weight: 6_000, price_per_km: 3.50, shipping_option: so_c)
      DistanceFee.create!(min_distance: 30, max_distance: 200, fee: 1.00, shipping_option: so_c)        
      Deadline.create!(min_distance: 40, max_distance: 600, deadline: 50, shipping_option: so_c)

      order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                            delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                            recipient_email: 'denise@email.com', recipient_phone_number: '2297523040', 
                            pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                            pick_up_postal_code: '30000000', sku: 'TV32P-SAMSUNG-XPTO90', height: 60, width: 40, length: 100, 
                            weight: 3_000, distance: 300, status: :pending)

      # Act
      

      # Assert
      expect(order.generate_quotations).to eq [{shipping_option: so_a, order: order, deadline: 48, price: 308},
                                               {shipping_option: so_b, order: order, deadline: 40, price: 454.5}]
    end
  end

  describe '#search_possible_shipping_options' do
    it 'retorna um array de modalidades de transporte possíveis para uma ordem de serviço' do
      # Arrange
      so_a = ShippingOption.create!(name: 'Entrega Expressa', min_distance: 50 , max_distance: 600, min_weight: 1_000, 
                                               max_weight: 50_000, delivery_fee: 5.50, status: :enabled)
      so_b = ShippingOption.create!(name: 'Entrega Básica', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)
      so_c = ShippingOption.create!(name: 'Outra Entrega', min_distance: 30 , max_distance: 800, min_weight: 1_500, max_weight: 40_000, 
                                    delivery_fee: 3.00, status: :enabled)

      price_a = Price.create!(min_weight: 1_000, max_weight: 2_000, price_per_km: 3.00, shipping_option: so_a)
      price_aa = Price.create!(min_weight: 2_001, max_weight: 4_000, price_per_km: 1.00, shipping_option: so_a)
      distance_fee_a = DistanceFee.create!(min_distance: 50, max_distance: 200, fee: 2.00, shipping_option: so_a)
      distance_fee_aa = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 2.50, shipping_option: so_a)
      deadline_a = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 30, shipping_option: so_a)
      deadline_aa = Deadline.create!(min_distance: 201, max_distance: 400, deadline: 48, shipping_option: so_a)

      price_b = Price.create!(min_weight: 1_500, max_weight: 2_000, price_per_km: 3.50, shipping_option: so_b)
      price_bb = Price.create!(min_weight: 3_000, max_weight: 4_000, price_per_km: 1.50, shipping_option: so_b)
      distance_fee_b = DistanceFee.create!(min_distance: 30, max_distance: 200, fee: 1.00, shipping_option: so_b)
      distance_fee_bb = DistanceFee.create!(min_distance: 201, max_distance: 350, fee: 1.50, shipping_option: so_b)
      deadline_b = Deadline.create!(min_distance: 60, max_distance: 200, deadline: 20, shipping_option: so_b)
      deadline_bb = Deadline.create!(min_distance: 300, max_distance: 400, deadline: 40, shipping_option: so_b)

      Price.create!(min_weight: 4_500, max_weight: 6_000, price_per_km: 3.50, shipping_option: so_c)
      DistanceFee.create!(min_distance: 30, max_distance: 200, fee: 1.00, shipping_option: so_c)        
      Deadline.create!(min_distance: 40, max_distance: 600, deadline: 50, shipping_option: so_c)

      order = Order.create!(delivery_address: 'Rua das Palmeiras, 13', delivery_city: 'Rio de Janeiro', delivery_state: 'RJ', 
                            delivery_postal_code: '28200000', recipient: 'Denise Silva', recipient_cpf: '00000000000',
                            recipient_email: 'denise@email.com', recipient_phone_number: '2297523040', 
                            pick_up_address: 'Estrada do Porto, 70', pick_up_city: 'São Paulo', pick_up_state: 'SP', 
                            pick_up_postal_code: '30000000', sku: 'TV32P-SAMSUNG-XPTO90', height: 60, width: 40, length: 100, 
                            weight: 3_000, distance: 300, status: :pending)

      # Act
      

      # Assert
      expect(order.search_possible_shipping_options).to eq [so_a, so_b]
    end
  end
end
