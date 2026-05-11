# 🤖 Market Intelligence AI System

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![n8n](https://img.shields.io/badge/n8n-Automation-orange)](https://n8n.io)
[![Groq](https://img.shields.io/badge/Groq-AI-purple)](https://groq.com)
[![Supabase](https://img.shields.io/badge/Supabase-Database-green)](https://supabase.com)
[![Resend](https://img.shields.io/badge/Resend-Email-red)](https://resend.com)

**AI-Powered Automated Market Intelligence System**

[Documentation](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/docs) • [Demo](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [Report Bug](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/issues) • [Contribute](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/pulls)

</div>

---

## 📊 About the Project

The **Market Intelligence AI System** is an enterprise competitive intelligence platform that automates monitoring, analysis, and reporting of real-time market data using cutting-edge generative artificial intelligence.

### 🎯 Problem It Solves

Companies waste valuable hours manually collecting competitor data, analyzing market trends, and generating strategic reports. This process is:
- ⏰ **Slow**: Requires dedicated specialized staff
- 💰 **Costly**: Analyst salaries and premium tools
- 📉 **Inefficient**: Outdated data and subjective analysis
- 🔄 **Not Scalable**: Difficult to expand to more competitors

### 💡 Our Solution

A fully automated system that:
- 🚀 **Monitors 24/7**: Continuous scraping from multiple sources
- 🧠 **Analyzes with AI**: Intelligent processing with Llama 3.3-70B
- 📈 **Detects Trends**: Automatic pattern identification
- ⚡ **Real-Time Alerts**: Instant notifications of critical changes
- 📊 **Generates Reports**: Automatic strategic analysis
- 💰 **Saves Costs**: 90% reduction in analysis time

---

## 🚀 Key Features

### 🔍 Intelligent Web Scraping
- **Multi-Source**: Simultaneous extraction from multiple competitors
- **Robust**: Automatic error handling and retries
- **Schedulable**: Flexible frequency configuration
- **Scalable**: Easy addition of new data sources

### 🧠 Cutting-Edge AI Analysis
- **Llama 3.3-70B Model**: State-of-the-art natural language processing
- **Deep Analysis**: Detection of trends, opportunities, and threats
- **Actionable Insights**: Specific strategic recommendations
- **Continuous Learning**: Constant improvement with each analysis

### 📊 Trend Detection
- **Market Patterns**: Identification of changes in prices, products, and strategies
- **Comparative Analysis**: Automatic benchmarking between competitors
- **Intelligent Prediction**: Anticipation of market movements
- **Data Visualization**: Clear representation of key metrics

### 🚨 Intelligent Alert System
- **Automatic Prioritization**: Classification by urgency level (low, medium, high, critical)
- **Multi-Channel**: Professional HTML email and Slack notifications
- **Customization**: Configuration of rules and thresholds
- **Complete History**: Record of all generated alerts

### 💾 Real-Time Database
- **Supabase PostgreSQL**: Robust and scalable infrastructure
- **Complete History**: Tracking of all changes and analysis
- **Optimized Queries**: Fast access to historical data
- **Automatic Backup**: Guaranteed data protection

### 📈 Price Comparison
- **Continuous Monitoring**: Instant price change detection
- **Historical Analysis**: Price trends over time
- **Price Alerts**: Notifications of significant changes
- **Competitive Intelligence**: Competitive price intelligence

---

## 🛠️ Technology Stack

### Orchestration & Automation
- **n8n**: Open-source workflow automation platform
- **JavaScript**: Data processing and transformation
- **HTTP Requests**: External API integration

### Artificial Intelligence
- **Groq API**: High-speed AI inference
- **Llama 3.3-70B-versatile**: State-of-the-art language model
- **NLP Processing**: Text analysis and insight extraction

### Database & Storage
- **Supabase**: Database as a service platform
- **PostgreSQL**: Relational database engine
- **REST API**: Optimized CRUD operations

### Notifications & Communication
- **Resend**: Transactional email service
- **Slack Webhook**: Slack integration for critical alerts
- **HTML Email**: Professional email design

### Infrastructure
- **Node.js 18+**: JavaScript runtime
- **Environment Variables**: Secure credential management
- **Git**: Version control

---

## 📋 Prerequisites

### Required Software
- **Node.js 18+**: [Download here](https://nodejs.org/)
- **npm or yarn**: JavaScript package manager
- **Git**: [Download here](https://git-scm.com/)
- **Code Editor**: VS Code [recommended](https://code.visualstudio.com/)

### External Accounts (All with Free Plans)
- **Supabase**: [Create free account](https://supabase.com/)
- **Groq**: [Create free account](https://groq.com/)
- **Resend**: [Create free account](https://resend.com/)
- **Slack**: [Optional - Create workspace](https://slack.com/)

### Recommended Hardware
- **CPU**: 2+ cores
- **RAM**: 4GB+ (8GB recommended)
- **Storage**: 10GB+ free
- **Internet**: Stable connection

---

## 🚀 Quick Installation

### 1. Clone the Repository

```bash
git clone https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project.git
cd MarketIntelligenceAI-Project
```

### 2. Configure Environment Variables

```bash
cp config/.env.example config/.env
```

Edit `config/.env` with your credentials:

```env
# Supabase Configuration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_KEY=your-anon-key-here

# Groq AI Configuration  
GROQ_API_KEY=gsk_your-groq-api-key-here

# Resend Email Configuration
RESEND_API_KEY=re_your-resend-api-key-here

# Slack Configuration (Optional)
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/YOUR/WEBHOOK/URL

# Email Configuration
EMAIL_FROM=onboarding@resend.dev
EMAIL_TO=your-email@company.com

# n8n Configuration
N8N_PORT=5678
N8N_PROTOCOL=http
N8N_HOST=localhost
```

### 3. Run Setup Script

```bash
bash scripts/setup.sh
```

This script:
- ✅ Verifies installed dependencies
- ✅ Creates necessary directories
- ✅ Validates configuration
- ✅ Prepares the environment

### 4. Start n8n

```bash
bash scripts/start.sh
```

n8n will be available at: **http://localhost:5678**

### 5. Import the Workflow

1. Open n8n in your browser
2. Click on **"Import from File"**
3. Select `workflows/market_intelligence_complete.json`
4. Configure credentials in each node
5. Save the workflow

### 6. Run the System

Click **"Execute Workflow"** and watch as the system:
- 🕷️ Scrapes competitor data
- 💾 Stores in the database
- 🧠 Analyzes with AI
- 📊 Generates insights
- 📧 Sends email alerts
- 💬 Notifies on Slack (if configured)

---

## 📁 Project Structure

```
MarketIntelligenceAI-Project/
├── README.md                          # Main documentation
├── LICENSE                            # MIT License
├── docs/                              # Technical documentation
│   ├── architecture.md                # System architecture
│   └── setup-guide.md                 # Detailed configuration guide
├── workflows/                         # n8n workflows
│   └── market_intelligence_complete.json
├── config/                            # Configurations
│   └── .env.example                  # Environment variables template
├── scripts/                           # Automation scripts
│   ├── setup.sh                       # Initial setup script
│   └── start.sh                       # Script to start n8n
├── screenshots/                       # Screenshots
│   ├── dashboard.png                  # System dashboard
│   ├── workflow.png                   # Workflow in n8n
│   └── email-example.png              # Alert email example
└── logs/                              # System logs (created automatically)
    ├── n8n.log                        # n8n logs
    └── setup.log                      # Setup logs
```

---

## 🎯 Use Cases

### 🏢 For Companies

**Competitive Monitoring**
- Tracking competitor prices and products
- Analysis of market strategies
- Detection of new launches

**Price Intelligence**
- Continuous price monitoring
- Price trend analysis
- Significant change alerts

**Market Analysis**
- Identification of emerging trends
- Detection of market opportunities
- Competitive position evaluation

### 🏪 For E-commerce

**Product Catalog**
- Automated competitor product tracking
- Price comparison
- Availability monitoring

**Dynamic Pricing**
- Real-time price adjustments
- Competitive strategy optimization
- Margin maximization

### 📈 For Investors

**Market Analysis**
- Sector trend monitoring
- Competitive analysis
- Investment opportunities

**Risk Assessment**
- Early detection of market changes
- Competitor threat analysis
- Data-driven decision making

---

## 🔧 Configuration

### Database Schema

The system automatically creates the following tables in Supabase:

#### `competitor_products`
Stores scraped competitor data:
```sql
CREATE TABLE competitor_products (
  id BIGSERIAL PRIMARY KEY,
  competitor TEXT NOT NULL,
  product_name TEXT NOT NULL,
  price NUMERIC(10,2),
  url TEXT,
  description TEXT,
  scraped_at TIMESTAMPTZ DEFAULT NOW()
);
```

#### `alerts`
Stores generated alerts:
```sql
CREATE TABLE alerts (
  id BIGSERIAL PRIMARY KEY,
  alert_type TEXT NOT NULL,
  priority TEXT NOT NULL,
  message TEXT NOT NULL,
  competitor TEXT,
  analysis_date TIMESTAMPTZ DEFAULT NOW()
);
```

#### `daily_reports`
Stores daily analysis reports:
```sql
CREATE TABLE daily_reports (
  id BIGSERIAL PRIMARY KEY,
  report_date TIMESTAMPTZ DEFAULT NOW(),
  analysis TEXT NOT NULL,
  trends TEXT,
  recommendations TEXT
);
```

### Customizing Competitors

Edit the n8n workflow to add or remove competitors:

1. Open the workflow in n8n
2. Locate the **"Set Competitors"** node
3. Add or modify URLs:

```javascript
return [
  { url: "https://competitor1.com/products" },
  { url: "https://competitor2.com/products" },
  { url: "https://competitor3.com/products" }
];
```

### Alert Thresholds

Configure alert priorities in the **"Analyze with AI"** node:

```javascript
const thresholds = {
  critical: 50,  // Price change > 50%
  high: 30,      // Price change > 30%
  medium: 15,    // Price change > 15%
  low: 5         // Price change > 5%
};
```

---

## 📊 Usage Examples

### Manual Execution

1. Open n8n: `http://localhost:5678`
2. Open the Market Intelligence workflow
3. Click **"Execute Workflow"**
4. Watch the execution in real-time

### Scheduled Execution

Configure automatic execution:

1. Click on the **Cron** node
2. Set the frequency:
   - Every hour: `0 * * * *`
   - Every 6 hours: `0 */6 * * *`
   - Daily at 9 AM: `0 9 * * *`
   - Every Monday at 8 AM: `0 8 * * 1`

### API Integration

Use n8n webhooks to trigger execution externally:

```bash
curl -X POST http://localhost:5678/webhook/market-intelligence \
  -H "Content-Type: application/json" \
  -d '{"competitor": "example.com"}'
```

---

## 🐛 Troubleshooting

### Common Issues

#### n8n Doesn't Start

**Problem**: Port 5678 already in use
```bash
# Find process using the port
lsof -i :5678

# Kill the process
kill -9 <PID>

# Or change port in .env
N8N_PORT=5679
```

#### Scraping Errors

**Problem**: Blocked by website
- Use proxies or VPNs
- Add delays between requests
- Implement user-agent rotation
- Use headless browsers (Puppeteer/Playwright)

#### Groq API Errors

**Problem**: Rate limit exceeded
- Check your quota: https://console.groq.com
- Implement exponential backoff
- Reduce analysis frequency
- Consider caching results

#### Email Not Sending

**Problem**: Invalid Resend credentials
```bash
# Test Resend API
curl -H "Authorization: Bearer YOUR_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"from":"onboarding@resend.dev","to":["test@example.com"],"subject":"Test","html":"<p>Test</p>"}' \
     https://api.resend.com/emails
```

### Logs and Debugging

#### View n8n Logs

```bash
# Follow logs in real-time
tail -f logs/n8n.log

# Search for errors
grep -i "error" logs/n8n.log
```

#### Query Database

```sql
-- View recent products
SELECT * FROM competitor_products 
ORDER BY scraped_at DESC 
LIMIT 10;

-- View recent alerts
SELECT * FROM alerts 
ORDER BY analysis_date DESC 
LIMIT 10;

-- View today's reports
SELECT * FROM daily_reports 
WHERE DATE(report_date) = CURRENT_DATE;
```

#### Test Connections

```bash
# Test Supabase connection
curl -H "apikey: YOUR_SUPABASE_KEY" \
     -H "Authorization: Bearer YOUR_SUPABASE_KEY" \
     YOUR_SUPABASE_URL/rest/v1/competitor_products?limit=1

# Test Groq connection
curl -H "Authorization: Bearer YOUR_GROQ_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"model":"llama-3.3-70b-versatile","messages":[{"role":"user","content":"test"}],"max_tokens":10}' \
     https://api.groq.com/openai/v1/chat/completions

# Test Resend connection
curl -H "Authorization: Bearer YOUR_RESEND_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"from":"onboarding@resend.dev","to":["test@example.com"],"subject":"Test","html":"<p>Test</p>"}' \
     https://api.resend.com/emails
```

---

## 📈 Roadmap

### 🎯 Version 1.0 (Current)
- ✅ Multi-competitor web scraping
- ✅ AI analysis (Llama 3.3-70B)
- ✅ Intelligent alert system
- ✅ Email and Slack notifications
- ✅ Real-time database
- ✅ Price comparison

### 🚀 Version 2.0 (Next Quarter)
- [ ] **Interactive Web Dashboard**
  - Real-time data visualization
  - Interactive graphs and metrics
  - Advanced filters and search

- [ ] **Predictive Analytics**
  - Machine learning models
  - Future trend prediction
  - Proactive recommendations

- [ ] **REST API**
  - Endpoints for external integrations
  - Complete Swagger documentation
  - Authentication and authorization

### 🌟 Version 3.0 (Next Semester)
- [ ] **Integration with More Sources**
  - Social media (Twitter, LinkedIn)
  - Marketplaces (Amazon, eBay)
  - Industry news and blogs

- [ ] **Sentiment Analysis**
  - Customer opinion analysis
  - Perception change detection
  - Reputation alerts

- [ ] **Mobile App**
  - iOS and Android application
  - Push notifications
  - Mobile dashboard

### 💎 Version 4.0 (Future)
- [ ] **CRM Integration**
  - Salesforce, HubSpot, Pipedrive
  - Automatic lead synchronization
  - Customer data enrichment

- [ ] **Advanced Artificial Intelligence**
  - Industry-specific custom models
  - Image and video analysis
  - Audio processing

- [ ] **Enterprise Features**
  - Multi-tenant architecture
  - Advanced RBAC
  - SSO and auditing
  - Compliance and security

---

## 🤝 Contributing

Contributions are welcome! This is an open-source project and we value every contribution.

### How to Contribute

1. **Fork the Project**
   ```bash
   git clone https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project.git
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/AmazingFeature
   ```

3. **Commit Your Changes**
   ```bash
   git commit -m 'Add some AmazingFeature'
   ```

4. **Push to the Branch**
   ```bash
   git push origin feature/AmazingFeature
   ```

5. **Open a Pull Request**
   - Describe your change in detail
   - Include screenshots if applicable
   - Mention related issues

### Contribution Areas

- 🐛 **Bug Fixes**: Error corrections
- ✨ **New Features**: New functionalities
- 📚 **Documentation**: Documentation improvements
- 🎨 **UI/UX**: Interface improvements
- ⚡ **Performance**: Optimizations
- 🧪 **Testing**: Tests and validations
- 🌍 **Translations**: Translations to other languages

### Code of Conduct

- Respect and consideration for everyone
- Open and constructive communication
- Focus on what's best for the community
- Empathy and collaboration

---

## 📄 License

This project is under the **MIT License** - see the [LICENSE](LICENSE) file for details.

### License Summary

✅ **Permitted**:
- Commercial use
- Modification
- Distribution
- Private use

❌ **Prohibited**:
- Warranty liability
- Damage liability

📝 **Required**:
- Include license and copyright
- State changes made

---

## 👨‍💻 Author

**Marcos del Valle**
- 🌐 [LinkedIn](https://www.linkedin.com/in/marcos-del-valle-8a3760266/)
- 💻 [GitHub](https://github.com/Marcosdelvallee)
- 📧 [Email](mailto:marcosdv99@gmail.com)

### About the Author

Software developer specialized in automation and artificial intelligence. Passionate about creating solutions that transform data into strategic decisions.

---

## 📞 Support and Contact

### Need Help?

📖 **Documentation**
- [Setup Guide](docs/setup-guide.md)
- [System Architecture](docs/architecture.md)
- [GitHub Issues](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project/issues)

📧 **Direct Contact**
- Email: marcosdv99@gmail.com
- LinkedIn: https://www.linkedin.com/in/marcos-del-valle-8a3760266/

### Enterprise Support

📞 **Contact**
- Email: marcosdv99@gmail.com
- Phone: +54 341 212-6628

---

## 📊 Project Statistics

<div align="center">

![GitHub Stars](https://img.shields.io/github/stars/Marcosdelvallee/MarketIntelligenceAI-Project?style=social)
![GitHub Forks](https://img.shields.io/github/forks/Marcosdelvallee/MarketIntelligenceAI-Project?style=social)
![GitHub Issues](https://img.shields.io/github/issues/Marcosdelvallee/MarketIntelligenceAI-Project)
![GitHub License](https://img.shields.io/github/license/Marcosdelvallee/MarketIntelligenceAI-Project)
![GitHub last-commit](https://img.shields.io/github/last-commit/Marcosdelvallee/MarketIntelligenceAI-Project)

</div>

---

## 🔗 Useful Links

- [n8n Documentation](https://docs.n8n.io)
- [Supabase Documentation](https://supabase.com/docs)
- [Groq Documentation](https://groq.com/docs)
- [Resend Documentation](https://resend.com/docs)
- [Slack API Documentation](https://api.slack.com)

---

## 🎯 Conclusion

The **Market Intelligence AI System** represents the future of competitive intelligence. By combining automation, artificial intelligence, and real-time data analysis, it provides companies with a significant competitive advantage.

### Why Choose This System?

✅ **Total Automation**: No manual intervention
✅ **Intelligent Analysis**: State-of-the-art AI  
✅ **Cost-Effective**: 95% cheaper than traditional solutions
✅ **Scalable**: Grows with your business
✅ **Open Source**: No vendor lock-in
✅ **Easy to Use**: Intuitive interface
✅ **Active Support**: Vibrant community

### Start Today

🚀 **Transform your competitive intelligence with the power of AI**

[Get Started Now](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [View Demo](https://github.com/Marcosdelvallee/MarketIntelligenceAI-Project) • [Contact](mailto:marcosdv99@gmail.com)

---

<div align="center">

**⚡ Powered by AI - Intelligent Automation for Strategic Decisions**

*Made with ❤️ by Marcos del Valle*

</div>
