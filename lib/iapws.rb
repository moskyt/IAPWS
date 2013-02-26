require "iapws/version"

module Iapws
  module Region1
    require 'bigdecimal'

    def self.rho(p,t)
      # water density - region 1 of IAPWS97
      # p - pressure in MPa
      # t - temperature in K
      #constants for gibbs
      coeficients = [
        " 1  0  -2  0.14632971213167",
        " 2  0  -1 -0.84548187169114",
        " 3  0   0 -0.37563603672040e+1",
        " 4  0   1  0.33855169168385e+1",
        " 5  0   2 -0.95791963387872",
        " 6  0   3  0.15772038513228",
        " 7  0   4 -0.16616417199501e-1",
        " 8  0   5  0.81214629983568e-3",
        " 9  1  -9  0.28319080123804e-3",
        "10  1  -7 -0.60706301565874e-3",
        "11  1  -1 -0.18990068218419e-1",
        "12  1   0 -0.32529748770505e-1",
        "13  1   1 -0.21841717175414e-1",
        "14  1   3 -0.52838357969930e-4",
        "15  2  -3 -0.47184321073267e-3",
        "16  2   0 -0.30001780793026e-3",
        "17  2   1  0.47661393906987e-4",
        "18  2   3 -0.44141845330846e-5",
        "19  2  17 -0.72694996297594e-15",
        "20  3  -4 -0.31679644845054e-4",
        "21  3   0 -0.28270797985312e-5",
        "22  3   6 -0.85205128120103e-9",
        "23  4  -5 -0.22425281908000e-5",
        "24  4  -2 -0.65171222895601e-6",
        "25  4  10 -0.14341729937924e-12",
        "26  5  -8 -0.40516996860117e-6",
        "27  8 -11 -0.12734301741641e-8",
        "28  8  -6 -0.17424871230634e-9",
        "29 21 -29 -0.68762131295531e-18",
        "30 23 -31  0.14478307828521e-19",
        "31 29 -38  0.26335781662795e-22",
        "32 30 -39 -0.11947622640071e-22",
        "33 31 -40  0.18228094581404e-23",
        "34 32 -41 -0.93537087292458e-25" ]
      n, ii, j = {}, {}, {}
      coeficients.each do |l|
        bar = l.split
        i = bar[0].to_i
        ii[i] = bar[1].to_i
        j[i] = bar[2].to_i
        n[i] = BigDecimal.new(bar[3])
      end
      #pi
      p = BigDecimal.new(p.to_s)
      pp = p / BigDecimal.new("16.53")
      #tau
      t = BigDecimal.new(t.to_s)
      tt = BigDecimal.new("1386.0") / t
      #gas constant
      r = BigDecimal.new("0.461526")

      px = BigDecimal.new("7.1")-pp
      tx = tt-BigDecimal.new("1.222")
      #gibbs derivative along pi
      gpi = BigDecimal.new("0.0")
      coeficients = (1..34).collect do |i|
        (-1) * n[i] * ii[i] * (px ** (ii[i] - 1)) * (tx ** j[i])
      end
      gpi = coeficients.inject{|s, x| s + x}

      rho = p / (pp * gpi * r * t)

      raise "Water density is not a number for p = #{p} and t = #{t}" if rho != rho

      rho.to_f
    end
  end
end
