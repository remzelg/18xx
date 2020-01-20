# frozen_string_literal: true

require './spec/spec_helper'
require 'engine/city'
require 'engine/junction'
require 'engine/tile'
require 'engine/town'

module Engine
  describe Tile do
    let(:edge0) { Edge.new(0) }
    let(:edge2) { Edge.new(2) }
    let(:edge3) { Edge.new(3) }
    let(:edge4) { Edge.new(4) }
    let(:edge5) { Edge.new(5) }
    let(:city) { City.new(20) }
    let(:town) { Town.new(10) }
    let(:townA) { Town.new(10, 'A') }
    let(:townB) { Town.new(10, 'B') }
    let(:junction) { Junction.new }

    describe '.for' do
      it 'should render basic tile' do
        expect(Tile.for('8')).to eq(
          Tile.new('8', color: :yellow, parts: [Path.new(edge0, edge2)])
        )
      end

      it 'should render a lawson track tile' do
        actual = Tile.for('81A')

        expected = Tile.new(
          '81A',
          color: :green,
          parts: [Path.new(edge0, junction), Path.new(edge2, junction), Path.new(edge4, junction)]
        )

        expect(actual).to eq(expected)
      end

      it 'should render a city' do
        expect(Tile.for('57')).to eq(
          Tile.new('57', color: :yellow, parts: [city, Path.new(edge0, city), Path.new(city, edge3)])
        )
      end

      it 'should render a town' do
        expect(Tile.for('3')).to eq(
          Tile.new('3', color: :yellow, parts: [town, Path.new(edge0, town), Path.new(town, edge5)])
        )
      end

      it 'should render a double town' do
        actual = Tile.for('1')

        expected = Tile.new(
          '1',
          color: :yellow,
          parts: [
            townA,
            Path.new(edge0, townA),
            Path.new(townA, edge2),
            townB,
            Path.new(edge3, townB),
            Path.new(townB, edge5),
          ]
        )
        expect(actual).to eq(expected)
      end
    end
  end
end
