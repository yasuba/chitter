require 'spec_helper'

describe Peep do

  context 'Posting peeps to chitter' do

    it 'should be created and then retreived from the db' do
      expect(Peep.count).to eq(0)
      Peep.create(:content => "A status update of fewer than 140 characters")
      expect(Peep.count).to eq(1)
      peep = Peep.first
      expect(peep.content).to eq("A status update of fewer than 140 characters")
      peep.destroy
      expect(Peep.count).to eq (0)
    end
  end

end
