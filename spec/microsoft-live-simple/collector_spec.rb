require 'spec_helper'

describe MicrosoftLive::Collector do
  before :all do
    class Foo
      attr_accessor :data, :simple
      def initialize(data:, simple:)
        self.data = data
        self.simple = simple
      end
    end
  end
  describe 'initialization' do
    before do
      @good_args = {
        simple: double('simple'),
        path: '/x',
        limit: 20,
        offset: 0,
        item_class: 'Object'
      }
    end
    it 'requires :simple' do
      expect{described_class.new(@good_args.except(:simple))}.to raise_error(ArgumentError).with_message('missing keyword: simple')
    end
    it 'requires :path' do
      expect{described_class.new(@good_args.except(:path))}.to raise_error(ArgumentError).with_message('missing keyword: path')
    end
    it 'requires :limit' do
      expect{described_class.new(@good_args.except(:limit))}.to raise_error(ArgumentError).with_message('missing keyword: limit')
    end
    it 'requires :offset' do
      expect{described_class.new(@good_args.except(:offset))}.to raise_error(ArgumentError).with_message('missing keyword: offset')
    end
    it 'requires :item_class' do
      expect{described_class.new(@good_args.except(:item_class))}.to raise_error(ArgumentError).with_message('missing keyword: item_class')
    end
  end

  describe '#items' do
    before do
      @good_args = {
        simple: double('simple'),
        path: '/x',
        limit: 20,
        offset: 0,
        item_class: Foo
      }
      @collector = described_class.new(@good_args)
    end
    context 'when :data' do
      context 'is empty' do
        before do
          expect(@good_args[:simple]).to receive(:get_collection) do
            { data: [ ] }
          end
        end
        it 'returns an empty array' do
          expect(@collector.items).to eq [ ]
        end
      end
      context 'is not empty' do
        before do
          expect(@good_args[:simple]).to receive(:get_collection) do
            { data: [ 'hello' ] }
          end
        end
        it 'returns an array of :item_class objects' do
          items = @collector.items
          expect(items.first.class).to eq Foo
          expect(items.first.data).to eq 'hello'
          expect(items.first.simple).to eq @good_args[:simple]
        end
      end
    end
  end

  describe '#next_page' do
    before do
      @good_args = {
        simple: double('simple'),
        path: '/x',
        limit: 20,
        offset: 0,
        item_class: Foo
      }
      @collector = described_class.new(@good_args)

      expect(@collector).to receive(:offset){ 0 }
      expect(@collector).to receive(:offset=).with(@collector.page_size)
      expect(@collector).to receive(:items)
    end
    it 'increases #offset by #page_size and calls #items' do
      @collector.next_page
    end
  end
end
