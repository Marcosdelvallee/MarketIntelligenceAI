# 📊 Workflows Directory

This directory contains n8n workflow files for the Market Intelligence AI System.

## 📋 Available Workflows

### Main Workflow

#### `Market Intelligence - Complete Workflow PROJECT.json`

**Description:** Complete automated market intelligence workflow that scrapes competitor data, analyzes it with AI, and sends strategic alerts.

**Features:**
- Multi-source web scraping
- AI-powered analysis with Groq (Llama 3.3-70B)
- Intelligent alert system
- Email and Slack notifications
- Real-time database storage
- Price monitoring and comparison

**Nodes:** 20+ interconnected nodes

**Execution Time:** ~5-10 minutes (depending on data volume)

**Last Updated:** 2026-05-10

## 🚀 How to Use

### Importing the Workflow

1. Open n8n in your browser (http://localhost:5678)
2. Click on "Import from File" in the top right corner
3. Navigate to this directory
4. Select `Market Intelligence - Complete Workflow PROJECT.json`
5. Click "Import"

### Configuring the Workflow

After importing, you need to configure credentials in each node:

#### HTTP Request Nodes
- **Competitor Scrapers:** Configure URLs for your competitors
- **Supabase Operations:** Add your Supabase URL and API key
- **Groq Analysis:** Add your Groq API key
- **Resend Email:** Add your Resend API key
- **Slack Webhook:** Add your Slack webhook URL (optional)

#### Code Nodes
- **Data Processing:** May need adjustment for different competitor APIs
- **Alert Logic:** Customize priority rules if needed
- **Email Template:** Modify HTML template for branding

### Running the Workflow

#### Manual Execution
1. Open the imported workflow
2. Click "Execute Workflow" in the top right corner
3. Monitor execution in real-time
4. Review results in each node

#### Scheduled Execution
1. Add a "Schedule Trigger" node at the beginning
2. Configure cron expression (e.g., `0 9 * * *` for daily 9 AM)
3. Connect trigger to the first node
4. Click "Activate" to enable automatic execution

## 🔧 Customization

### Adding New Competitors

1. Add a new "HTTP Request" node
2. Configure the competitor's API/URL
3. Connect to "Data Processing" node
4. Update competitor detection logic in Data Processing

### Modifying Alert Rules

Edit the "Alert Logic" node to change priority thresholds:

```javascript
// Example: Make critical alerts more strict
if (analysisData.trends && analysisData.trends.length > 5) {
  priority = 'critical';
}
```

### Customizing Email Template

Modify the HTML in the "Alert Logic" node to add:
- Company branding
- Custom colors
- Additional data sections
- Links to dashboards

## 📊 Workflow Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    DATA ACQUISITION                       │
│  ┌──────────────┐  ┌──────────────┐                     │
│  │ Competitor 1 │  │ Competitor 2 │                     │
│  │   Scraper    │  │   Scraper    │                     │
│  └──────────────┘  └──────────────┘                     │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    DATA PROCESSING                       │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Data Processing Node                   │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    DATA STORAGE                          │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Save to Supabase                         │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    AI ANALYSIS                            │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Groq Analysis Node                     │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    INSIGHT PROCESSING                     │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Insight Processing Node                │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────┐
│                    ALERT LOGIC                            │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Alert Logic Node                        │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                         │
                    ┌────┴────┐
                    ▼         ▼
┌──────────────────┐  ┌──────────────────┐
│  Email Alert     │  │  Slack Alert     │
│  (Resend)        │  │  (Webhook)       │
└──────────────────┘  └──────────────────┘
         │                     │
         └──────────┬──────────┘
                    ▼
┌─────────────────────────────────────────────────────────┐
│                    DATA PERSISTENCE                       │
│  ┌──────────────────────────────────────────────────┐   │
│  │           Save Alert to Supabase                  │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## 🔍 Troubleshooting

### Common Issues

**Workflow fails to import:**
- Ensure you're using a compatible n8n version
- Check that the JSON file is not corrupted
- Try importing a smaller section first

**Nodes show authentication errors:**
- Verify API keys are correct
- Check that credentials are properly configured
- Ensure API keys have necessary permissions

**Data processing returns empty results:**
- Check competitor URLs are accessible
- Verify API responses are in expected format
- Review Data Processing node logic

**Emails not being sent:**
- Verify Resend API key is valid
- Check email domain is verified
- Review email content for formatting issues

**Slack notifications not working:**
- Verify webhook URL is correct
- Check webhook is active in Slack
- Ensure priority is set to "critical"

## 📈 Performance Optimization

### Reducing Execution Time

1. **Parallel Processing:** Enable parallel execution for independent nodes
2. **Batch Operations:** Process data in batches instead of individually
3. **Caching:** Cache frequently accessed data
4. **Optimized Queries:** Use database indexes effectively

### Handling Large Datasets

1. **Pagination:** Process data in pages
2. **Streaming:** Use streaming for large responses
3. **Async Processing:** Use background processing for heavy operations
4. **Resource Management:** Monitor memory and CPU usage

## 🔒 Security Considerations

### Protecting Sensitive Data

1. **Never commit API keys** in workflow files
2. **Use n8n credentials** for storing secrets
3. **Environment variables** for configuration
4. **Encrypt sensitive data** when possible

### Access Control

1. **Restrict workflow access** to authorized users
2. **Use n8n authentication** for workflow access
3. **Audit workflow executions** regularly
4. **Monitor for suspicious activity**

## 📝 Version Control

### Workflow Updates

When updating workflows:

1. **Export current version** before making changes
2. **Document changes** in workflow comments
3. **Test thoroughly** before deploying
4. **Backup previous versions** for rollback

### Git Workflow

```bash
# Export workflow from n8n
# Save to this directory

# Commit changes
git add workflows/
git commit -m "Update workflow: description of changes"

# Push to repository
git push origin main
```

## 🤝 Contributing

### Adding New Workflows

1. Create new workflow file
2. Test thoroughly
3. Document functionality
4. Update this README
5. Submit pull request

### Workflow Standards

- Use descriptive node names
- Add comments for complex logic
- Include error handling
- Document external dependencies
- Follow naming conventions

## 📞 Support

For workflow-related issues:
- Check main documentation
- Review n8n documentation
- Open an issue on GitHub
- Contact development team

## 📚 Additional Resources

- [n8n Documentation](https://docs.n8n.io)
- [Workflow Examples](https://n8n.io/workflows/)
- [Node Reference](https://docs.n8n.io/integrations/builtin/)

---

**Last Updated:** May 10, 2026

**Workflow Version:** 1.0.0

**Maintained by:** Market Intelligence AI Team