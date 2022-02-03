require_relative "../../game/player_components/input_taker"

describe InputTaker do

  let(:choices) { [:hello, :bye] }

  describe ".get_choice" do
    context "when user gives valid choice" do

      let(:input_taker) do
        input_handler = StringIO.new(choices[0].to_s + "\n")
        InputTaker.new(input_handler: input_handler)
      end

      it "should return sympol" do
        expect(input_taker.get_choice(choices).is_a? Symbol).to be true
      end

      it "should downcase input" do
        expect(input_taker.get_choice(choices)).to eql(choices[0])
      end
    end

    context "when user gives exit choice" do
      it "should return exit_choice" do
        input_handler = StringIO.new(GameConstants::PLAYER_EXITED.to_s + "\n")
        input_taker = InputTaker.new(input_handler: input_handler)
        expect(input_taker.get_choice(choices)).to eql(GameConstants::PLAYER_EXITED)
      end
    end

    context "when user insistes on giving wrong option" do
      it "should return exit_choice" do
        user_input = ""
        (GameConstants::CHOICE_TRIAL + 1).times do
          user_input += choices.join("-").to_s + "\n"
        end
        input_handler = StringIO.new(user_input)
        input_taker = InputTaker.new(input_handler: input_handler)
        expect(input_taker.get_choice(choices)).to eql(GameConstants::PLAYER_EXITED)
      end
    end
  end
end
