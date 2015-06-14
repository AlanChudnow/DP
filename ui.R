library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Predict Your Run Time"),
    sidebarPanel(
        numericInput('iDkm','Prior Race Distance (m)',value = 5000, min = 50, max = 100000, step = 1000),
        numericInput('iTm', 'Prior Race Time Minutes', 30, min = 0, max = 60*24, step = 1),
        numericInput('iTs', 'Prior Race Time Seconds', 0, min = 0, max = 60, step = 1),
        numericInput('nDkm','New Race Distance (m)',value = 10000, min = 50, max = 100000, step = 1000)
            ),
    mainPanel(
        tabsetPanel(type = "tabs", 
                    tabPanel("Instructions",
                             HTML('
                                  <h4>Summary</h4>
                                  <p>This web app will predict the time to run a race in the future based upon the time it took you
                                  to run a race in the past.&nbsp; 
                                  To use the program, enter the following information and click to the race prediction tab:</p>
                                  <ul>
                                  <li>
                                  <p>Prior Race Distance (meters)</p>
                                  </li>
                                  <li>
                                  <p>Prior Race Time (min)</p>
                                  </li>
                                  <li>
                                  <p>Prior Race Time (Sec)</p>
                                  </li>
                                  <li>
                                  <p>New Race Length (meters).</p>
                                  </li>
                                  <li>
                                  <p>Note: A marathon is 42195 meters; a half-marathon 21097 meters</p>
                                  </li>
                                  </ul>
                                  
                                  <p>The app works by estimating your V02 max based upon the pace 
                                  and distance of the prior race using&nbsp; equations defined by the American College of Sports Medicine 
                                  and captured from the runnersweb.com (See links below).&nbsp; 
                                  It then solves for the new race time by reversing these equations to estimate the new time 
                                  assuming a constant VO2max.</p>
                                  
                                  <h4>Background</h4>
                                  
                                  <p>The amount of energy that your body can use for running 
                                  (and your maximum pace) is limited by the maximum volume of oxygen that your body can use. 
                                  VO2 max is the maximal oxygen uptake or the maximum volume of oxygen that can be utilized in one minute 
                                  during maximal or exhaustive exercise. It is measured as milliliters of oxygen used in one minute per 
                                  kilogram of body weight.&nbsp; Your VO2 max is to a large extent determined by genetics but most 
                                  people can increase their VO2 max by between 5%&nbsp; and 20% (increases of up to 60% have been 
                                  reported.</p>
                                  
                                  <p>The tables below lists the VO2 Max measured across the general population.&nbsp; Values in ml/kg/min.</p>
                                  
                                  <table align="center" border="1" cellpadding="1" cellspacing="1" style="width: 500px;">
                                  <thead>
                                  <tr>
                                  <th scope="col">
                                  <p><strong>Age</strong></p>
                                  </th>
                                  <th scope="col">
                                  <p><strong>Very&nbsp; Poor</strong></p>
                                  </th>
                                  <th scope="col"><strong>Poor</strong></th>
                                  <th scope="col"><strong>Fair</strong></th>
                                  <th scope="col"><strong>Good</strong></th>
                                  <th scope="col"><strong>Excellent</strong></th>
                                  <th scope="col"><strong>Superior</strong></th>
                                  </tr>
                                  </thead>
                                  <caption>
                                  <p><strong>VO2 Max in General Population (Female)</strong></p>
                                  </caption>
                                  <tbody>
                                  <tr>
                                  <td>13-19</td>
                                  <td>&lt;25.0</td>
                                  <td>25.0 &ndash; 30.9</td>
                                  <td>31.0 &ndash; 34.9</td>
                                  <td>35.0 &ndash; 38.9</td>
                                  <td>39.0 &ndash; 41.9</td>
                                  <td>&gt;41.9</td>
                                  </tr>
                                  <tr>
                                  <td>20-29</td>
                                  <td>&lt;23.6</td>
                                  <td>23.6 &ndash; 28.9</td>
                                  <td>29.0 &ndash; 32.9</td>
                                  <td>33.0 &ndash; 36.9</td>
                                  <td>37.0 &ndash; 41.0</td>
                                  <td>&gt;41.0</td>
                                  </tr>
                                  <tr>
                                  <td>30-39</td>
                                  <td>&lt;22.8</td>
                                  <td>22.8 &ndash; 26.9</td>
                                  <td>27.0 &ndash; 31.4</td>
                                  <td>31.5 &ndash; 35.6</td>
                                  <td>35.7 &ndash; 40.0</td>
                                  <td>&gt;40.0</td>
                                  </tr>
                                  <tr>
                                  <td>40-49</td>
                                  <td>&lt;20.2</td>
                                  <td>21.0 &ndash; 24.4</td>
                                  <td>24.5 &ndash; 28.9</td>
                                  <td>29.0 &ndash; 32.8</td>
                                  <td>32.9 &ndash; 36.9</td>
                                  <td>&gt;36.9</td>
                                  </tr>
                                  <tr>
                                  <td>50-59</td>
                                  <td>&lt;20.2</td>
                                  <td>20.2 &ndash; 22.7</td>
                                  <td>22.8 &ndash; 26.9</td>
                                  <td>27.0 &ndash; 31.4</td>
                                  <td>31.5 &ndash; 35.7</td>
                                  <td>&gt;35.7</td>
                                  </tr>
                                  <tr>
                                  <td>60+</td>
                                  <td>&lt;17.5</td>
                                  <td>17.5 &ndash; 20.1</td>
                                  <td>20.2 &ndash; 24.4</td>
                                  <td>24.5 &ndash; 30.2</td>
                                  <td>30.3 &ndash; 31.4</td>
                                  <td>&gt;31.4</td>
                                  </tr>
                                  </tbody>
                                  </table>
                                  
                                  <table align="center" border="1" cellpadding="1" cellspacing="1" style="width: 500px;">
                                  <thead>
                                  <tr>
                                  <th scope="col">
                                  <p><strong>Age</strong></p>
                                  </th>
                                  <th scope="col">
                                  <p><strong>Very&nbsp; Poor</strong></p>
                                  </th>
                                  <th scope="col"><strong>Poor</strong></th>
                                  <th scope="col"><strong>Fair</strong></th>
                                  <th scope="col"><strong>Good<strong></th>
                                  <th scope="col"><strong>Excellent<strong></th>
                                  <th scope="col"><strong>Superior<strong></th>
                                  </tr>
                                  </thead>
                                  <caption>
                                  <p><strong>VO2 Max in General Population (Male)</strong></p>
                                  </caption>
                                  <tbody>
                                  <tr>
                                  <td>13-19</td>
                                  <td>&lt;35.0</td>
                                  <td>35.0 &ndash; 38.3</td>
                                  <td>38.4 &ndash; 45.1</td>
                                  <td>45.2 &ndash; 50.9</td>
                                  <td>51.0 &ndash; 55.9</td>
                                  <td>&gt;55.9</td>
                                  </tr>
                                  <tr>
                                  <td>20-29</td>
                                  <td>&lt;33.0</td>
                                  <td>33.0 &ndash; 36.4</td>
                                  <td>36.5 &ndash; 42.4</td>
                                  <td>42.5 &ndash; 46.4</td>
                                  <td>46.5 &ndash; 52.4</td>
                                  <td>&gt;52.4</td>
                                  </tr>
                                  <tr>
                                  <td>30-39</td>
                                  <td>&lt;31.5</td>
                                  <td>31.5 &ndash; 35.4</td>
                                  <td>35.5 &ndash; 40.9</td>
                                  <td>41.0 &ndash; 44.9</td>
                                  <td>45.0 &ndash; 49.4</td>
                                  <td>&gt;49.4</td>
                                  </tr>
                                  <tr>
                                  <td>40-49</td>
                                  <td>&lt;30.2</td>
                                  <td>30.2 &ndash; 33.5</td>
                                  <td>33.6 &ndash; 38.9</td>
                                  <td>39.0 &ndash; 43.7</td>
                                  <td>43.8 &ndash; 48.0</td>
                                  <td>&gt;48.0</td>
                                  </tr>
                                  <tr>
                                  <td>50-59</td>
                                  <td>&lt;26.1</td>
                                  <td>26.1 &ndash; 30.9</td>
                                  <td>31.0 &ndash; 35.7</td>
                                  <td>35.8 &ndash; 40.9</td>
                                  <td>41.0 &ndash; 45.3</td>
                                  <td>&gt;45.3</td>
                                  </tr>
                                  <tr>
                                  <td>60+</td>
                                  <td>&lt;20.5</td>
                                  <td>20.5 &ndash; 26.0</td>
                                  <td>26.1 &ndash; 32.2</td>
                                  <td>32.3 &ndash; 36.4</td>
                                  <td>36.5 &ndash; 44.2</td>
                                  <td>&gt;45.3</td>
                                  </tr>
                                  </tbody>
                                  </table>
                                  
                                  <p></p><p>Note:&nbsp; While some experts believe that VO2 max is a key 
                                  physiological determinant of an athlete&rsquo;s running performance, and that it is an important 
                                  objective of a training program to improve it, this view is controversial.&nbsp; &nbsp;Many other 
                                  sports scientists argue that the limits to an athlete&rsquo;s running performance are determined 
                                  by a range of factors &ndash; such as adaptation of muscles, running efficiency, metabolism &ndash; 
                                  and that VO2 max is simply a measure of the oxygen that the athlete consumes at the maximum level of 
                                  energy output. So treat this result as a fun game.</p>
                                  
                                  <h4>Equations</h4>
                                  
                                  <p>This program predicts your V02 Max using the following equations 
                                  and race time</p>
                                  
                                  <ul>
                                  <li>V is the velocity of prior run in meters/sec
                                    (prior race distance in meters)/(prior race time in seconds) </li>
                                  <li> Percent max determines the ratio of your effort to the maximum effort.&nbsp;<br />
                                  It is a based upon time.&nbsp; &nbsp;Percent_max = 0.8 + 0.1894393 * e^(-0.012778 * t) + 0.2989558 * e^(-0.1932605 * t)
                                  </li>
                                  <li> VO2 estimates the oxygen input required to sustain the velocity achieved in the prior rate.&nbsp;<br />
                                    VO2 = -4.60 + 0.182258 * v + 0.000104 * v^2
                                  </li>
                                  <li> VO2max is an estimate of your ability to intake oxygen and generate power from the prior race.<br />
                                  &nbsp; VO2MAX = VO2/percent_max</p>
                                  </li>
                                  
                                  <li> New Rate time is t&rsquo; that solves<br />
                                  &nbsp;VO2MAX = (4.60 + 0.182258 * v&rsquo; + 0.000104 * v&rsquo;^2) /<br />
                                  &nbsp; ( -4.60 + 0.182258 * v&rsquo; + 0.000104 * v&rsquo;^2);<br />
                                  where v&rsquo; = (new race distance in meters)/(t&rsquo; in seconds)
                                  </li>
                                  </ul>
                                  
                                  <p>&nbsp;</p>
                                  
                                  <h4>Links for more information</h4>
                                  
                                  <p><a href="http://www.runningforfitness.org/faq/vo2-max">http://www.runningforfitness.org/faq/vo2-max</a></p>
                                  
                                  <p><a href="http://www.runnersweb.com/running/rw_news_frameset.html?http://www.runnersweb.com/running/vo2.shtm">http://www.runnersweb.com/running/rw_news_frameset.html?http://www.runnersweb.com/running/vo2.shtm</a></p> 
                                  ') #HTML
                        ),   #Instruction Tab
                     tabPanel("Race Prediction",
                         h4('Your prior race was'),
                         verbatimTextOutput("oDstring"),
                         verbatimTextOutput("oTString"),
                         verbatimTextOutput("oVString"),
                         h4('Your prior race performance was '),
                         verbatimTextOutput("oVo2pace"),
                         verbatimTextOutput("oVo2max"),
                         h4('Your predicted race Time is: '),
                         verbatimTextOutput("oTpredict") 
                         )  #Race Prediction Tab

        ) #MainPanel
    )
))
